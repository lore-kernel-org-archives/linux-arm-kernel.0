Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E162085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQmsnyvE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hLBcjd/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E162085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=71CtzhHvptXwZxjx5cITS2Ji1EoK6DOMJ5hGUWHihOA=; b=EQmsnyvEbtfhV+
	45HEqyOEXhy9in2YPG2WBXI1QppQBo3AweP2xef0ZHAg5pgFoKA1yATBmL3a4gdFWKipXyrg7khYU
	ldZdo9xu6EJj9rVnq+bgqCQcrYog4d1xnu5bYiNcWsblDG17UJ0yWmeMPggYwRCMSuvN6tjSSjnTV
	7joJ0s3l6CwkNBJPm/M+ptWTMBglgjVhc1FMLsymPdJhY1Co7QLu9P8ou0OO3gMRUgzaOXF4juzgm
	x9OjrtVjtU2lj9n73i3Z9MDlcISm+nGtt6qBCWN8xk8BJhvaqCXjWecmurrkP7r3m2+aGnsgVdlr/
	p6669/w9qfnbi+vx3u+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLow-0001V7-LR; Wed, 23 Jan 2019 16:56:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLoj-0001Ic-9t
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:55:59 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190123165552euoutp0292c3e563a9ec8823419153db59722609~8iJabs_T41410514105euoutp02N
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 16:55:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190123165552euoutp0292c3e563a9ec8823419153db59722609~8iJabs_T41410514105euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548262552;
 bh=RkoOt0oX5YN6cG8lna4P3L0zCXBH0Dvj9mhMNweZGnE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=hLBcjd/vvSv/pUYvzp9Vwka+OAkTmRDzjGSbGrPzjixTpPfafhYxWdzm4SvG5+Chs
 F8a0qBMQ5RXD1D4rB3go/Yt+slqj2DOPZVgXroDsDmgGXvOBluAYwlw9VUC+sPz722
 yamDXzvbq7mh6WiTPrFX3kRlx3aF0kGAl+AxR5ow=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190123165551eucas1p136833794537c86578e6b468325bd99fa~8iJZP7g2p1655316553eucas1p13;
 Wed, 23 Jan 2019 16:55:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 3B.42.04806.69C984C5; Wed, 23
 Jan 2019 16:55:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190123165550eucas1p117692111e84223f957597903f9f1640d~8iJYWpIPJ1656916569eucas1p1x;
 Wed, 23 Jan 2019 16:55:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190123165549eusmtrp2bf274dc7ba9e08f106b231b594a0a621~8iJYH5sQa0112001120eusmtrp2H;
 Wed, 23 Jan 2019 16:55:49 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-81-5c489c960473
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.58.04128.59C984C5; Wed, 23
 Jan 2019 16:55:49 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190123165549eusmtip12603c382d3e189755b615776c24ba20e~8iJXWYIO60728707287eusmtip1I;
 Wed, 23 Jan 2019 16:55:48 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v2 0/3] add AES support for Exynos5433
Date: Wed, 23 Jan 2019 17:55:30 +0100
Message-Id: <20190123165533.29645-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7rT5njEGNzcZmCxccZ6Vos551tY
 LOYfOcdq0f1KxqJv339Gi/7Hr5ktzp/fwG6x6fE1Vov7934yWVzeNYfNYsb5fUwWa4/cZbdY
 ev0ik0Xr3iPsFv9/NTM78HusmbeG0WPLyptMHtsOqHpsWtXJ5rF5Sb3Hv4VTWDwOvtvD5NG3
 ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZf388ZS44w1Yx5c5ypgbGaaxdjBwcEgImEmsPmXYx
 cnIICaxglDg5J6qLkQvI/sIo8ff1XRYI5zOjxKqWC6wgVSANF092sUMkljNKnFrTzwLXMufM
 S2aQKjYBc4lH288wgdgiAsoSk+9NZwYpYhaYziJx48dsdpCEsICZxJ9Ti1lAbBYBVYkLb08w
 gtzEK+AiMXt5CMQ2eYlpq7vA5vAKCEqcnPkErJwZKN68dTbYTAmBc+wSS5YeZ4RocJE4+v4A
 G4QtLPHq+BZ2CFtG4v/O+UwQdrnE7q3P2CGaWxgl5k5eBJWwljh8/CI4YJgFNCXW79KHCDtK
 PG18xw4JLz6JG28FIW7gk5i0DeQvkDCvREebEES1rsS8/2eggSUt0fV/HZTtIXFp70p2SFDH
 Sqy/doN5AqPCLCSfzULy2SyEGxYwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITG2n
 /x3/uoNx35+kQ4wCHIxKPLwb8jxihFgTy4orcw8xSnAwK4nwul50ixHiTUmsrEotyo8vKs1J
 LT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAyCf5dYrZ1MNlvob77kqeE1b1U4jb
 /2TZp0Ua1x7/XLdqZY/pWV3BQtV5r2cdUNTWtdz2zHyf45GrDWddwt+qmS10/eq0zSaHJ2pn
 aVlTlw47+8l9GoUhjlo3HxX7+4XsDA78GOO24972giv9Sr9l/3eX6Spennjn062qHdMW8apv
 U3Fc93T9CSWW4oxEQy3mouJEANgSEO9pAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7pT53jEGHx+qG+xccZ6Vos551tY
 LOYfOcdq0f1KxqJv339Gi/7Hr5ktzp/fwG6x6fE1Vov7934yWVzeNYfNYsb5fUwWa4/cZbdY
 ev0ik0Xr3iPsFv9/NTM78HusmbeG0WPLyptMHtsOqHpsWtXJ5rF5Sb3Hv4VTWDwOvtvD5NG3
 ZRWjx+dNcgGcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWp
 Rfp2CXoZf388ZS44w1Yx5c5ypgbGaaxdjJwcEgImEhdPdrF3MXJxCAksZZSYPH8rE0RCWqLx
 9GooW1jiz7UuNoiiT4wSy97eBetmEzCXeLT9DFiRiICyxOR705lBipgFFrNIHHj3ASwhLGAm
 8efUYhYQm0VAVeLC2xOMXYwcHLwCLhKzl4dALJCXmLa6C6ycV0BQ4uTMJ2DlzEDx5q2zmScw
 8s1CkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYFxtO/Zzyw7GrnfBhxgFOBiV
 eHg5Cj1ihFgTy4orcw8xSnAwK4nwul50ixHiTUmsrEotyo8vKs1JLT7EaAp060RmKdHkfGDM
 55XEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYFxbrWT9m+OA+O9H
 zA6TAxZeWds5c8ezzw9n8e0sTOC9yNPauDLxf093T9ds2wyV0KCq9RcXmv0VVfhts5hfRHbu
 mubDk7cKRB55slJ2esON4IuTlguJfAp6O+/5NV7rh41x1zmcbsR9CBKePSlbu6XYXvXurQ/f
 JidyF9b5715U7+G+rm1f1AslluKMREMt5qLiRAAYv4M7wQIAAA==
X-CMS-MailID: 20190123165550eucas1p117692111e84223f957597903f9f1640d
X-Msg-Generator: CA
X-RootMTR: 20190123165550eucas1p117692111e84223f957597903f9f1640d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190123165550eucas1p117692111e84223f957597903f9f1640d
References: <CGME20190123165550eucas1p117692111e84223f957597903f9f1640d@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_085557_507432_45F1902B 
X-CRM114-Status: GOOD (  12.64  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Vladimir Zapolskiy <vz@mleia.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add slimSSS node to DT and crypto AES support for Exynos5433. Tested on
Exynos5433 board with crypto run-time self tests and with tcrypt with
command insmod tcrypt.ko mode=500 sec=1

Changes since v1:
- address Krzysztof Kozlowski review: add missing comma in struct
  definition, add goto for error code path, correct indentation,
  in documentation add that Exynos5433 has both slimSSS and SSS IPs.

Kamil Konieczny (3):
  arm64: dts: exynos: add SlimSSS for Exynos5433
  dt-bindings: crypto: document Exynos5433 SlimSSS
  crypto: s5p: add AES support for Exynos5433

 .../bindings/crypto/samsung-sss.txt           | 14 ++++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  9 ++++
 drivers/crypto/s5p-sss.c                      | 50 +++++++++++++++++--
 3 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
