Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33386217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UB/bCMXE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mndz7U9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33386217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zETYZ34sX+feHStAinTLqZzQX4aYU9FdESs5Ky3O0Gk=; b=UB/bCMXE2wHeQq
	5Ez+oxbRUbQC6KlqQw6wY1MJhUAhebjBxsmZAcTV7McO+bG2GiZhZVnGsmetvc2FCVIuAwl3oYACC
	dZ5geinjKysE1KQwLyTDXe6bXea3Z2twEiV8N/6dlVj59w3Px5lXmjA3fhvd8XUVFxqtCGU0ZUdgd
	yN20wQqwL+V7V9Lvkdeh2p6mRIbj/yGxIF9kXyjgaxCTpuefSPHITG0jtMcOL5o1zJsxG7etRRmly
	pYedSzVmg19q3tgYvMcO6NXm5cmqds2ebQ8LSgrXqeLtmkkTem59XwS7qh2vXde75AE3qqG/iuDgd
	4wWmMK0bonPYtQKrl5Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxwN-0006pP-6c; Tue, 22 Jan 2019 15:26:15 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxwJ-0006oj-Db
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:26:13 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190122152609euoutp01970fc48dd19e9b64aed360d38bc3eb39~8NRytxcyk0909509095euoutp01x
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 15:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190122152609euoutp01970fc48dd19e9b64aed360d38bc3eb39~8NRytxcyk0909509095euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548170769;
 bh=2z4956BPTrzPRPjdNWhR83ZczdIolr9hO2TuunA7tSI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=mndz7U9KT4YcRsHF/UHSOIaUXYTa0/BX44Q7fCLGYCWCW6S1X2uxKK67OBEFgeAWh
 KbCNZzU6mHP9V5AaCmhFJvywQuJ9U0Txwk9n0eHFhhQB1N7/e+3igg/OWJCMREvkR/
 xLEl/Tm2ys07a74CprLXFYWJCGBxc7yRl0UTQqz0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190122152608eucas1p27d3bf38de7ffaeda58aeb6afd1cb230b~8NRyPlTjY2790227902eucas1p2m;
 Tue, 22 Jan 2019 15:26:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.05.04441.016374C5; Tue, 22
 Jan 2019 15:26:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190122152607eucas1p2c58a7814bb9ab72cc46d5a84eb1962a4~8NRxfjHnC1613616136eucas1p2q;
 Tue, 22 Jan 2019 15:26:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190122152607eusmtrp209d6bb9c06a4bb7546f6b6283eb99ccc~8NRxQqyuR0539705397eusmtrp2V;
 Tue, 22 Jan 2019 15:26:07 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-71-5c473610edd4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.FF.04128.F06374C5; Tue, 22
 Jan 2019 15:26:07 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190122152606eusmtip21684cb60ce83d438761dc21877244256~8NRwnOi1p0523205232eusmtip2H;
 Tue, 22 Jan 2019 15:26:06 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v1 0/3] add AES support for Exynos5433
Date: Tue, 22 Jan 2019 16:25:50 +0100
Message-Id: <20190122152553.1537-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7oCZu4xBrs3SVhsnLGe1WLO+RYW
 i/lHzrFadL+Ssejb95/Rov/xa2aL8+c3sFtsenyN1eL+vZ9MFpd3zWGzmHF+H5PF2iN32S2W
 Xr/IZNG69wi7xf9fzcwO/B5r5q1h9Niy8iaTx7YDqh6bVnWyeWxeUu/xb+EUFo+D7/YwefRt
 WcXo8XmTXABnFJdNSmpOZllqkb5dAlfGyw8n2Qpes1ScuLWHqYHxAXMXIyeHhICJxO+FXUxd
 jFwcQgIrGCUm/P/PCOF8YZRYf/4WI0iVkMBnRomeFXAd09/9ZoEoWs4ocXbNNSa4jr7mmUwg
 VWwC5hKPtp8Bs0UElCUm35vODFLELDCdReLGj9nsIAlhATOJHbuXgtksAqoSxyc8BmvgFXCW
 eP5iHxPEOnmJaau7oOKCEidnPmEBsZmB4s1bZ4MNlRA4xS5xbV8LVIOLxL5lWxghbGGJV8e3
 sEPYMhL/d86HqimX2L31GTtEcwujxNzJi6AS1hKHj19k7WLkANqgKbF+lz5E2FHi3J07YGEJ
 AT6JG28FIW7gk5i0DeQxkDCvREebEES1rsS8/2dYIWxpia7/66BsD4mZ5z6zQkI0VmL+8wam
 CYwKs5B8NgvJZ7MQbljAyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjML2d/nf80w7G
 r5eSDjEKcDAq8fAmXHCNEWJNLCuuzD3EKMHBrCTC63rRLUaINyWxsiq1KD++qDQntfgQozQH
 i5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDo+AKV9Pr7vwccfryQYr2vE1P8wOu9/+RXmrr
 0iiV5G5jun+yoush5ao9wStWcLfVCS05wpTM+99xz7K94dcdao+xuC+M6NPweCXfUP7AkY1/
 xlr/NU8sdF7MKPR8yi30XDk/8Pr02ecia7UEq15deH2Jo/vjbS/T+FneSyYoez+p5yr7mTJN
 iaU4I9FQi7moOBEAcTsxP2sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7r8Zu4xBl83qFpsnLGe1WLO+RYW
 i/lHzrFadL+Ssejb95/Rov/xa2aL8+c3sFtsenyN1eL+vZ9MFpd3zWGzmHF+H5PF2iN32S2W
 Xr/IZNG69wi7xf9fzcwO/B5r5q1h9Niy8iaTx7YDqh6bVnWyeWxeUu/xb+EUFo+D7/YwefRt
 WcXo8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
 kb5dgl7Gyw8n2Qpes1ScuLWHqYHxAXMXIyeHhICJxPR3v1m6GLk4hASWMkpsfTaJDSIhLdF4
 ejUThC0s8edaFxtE0SdGia5ra9lBEmwC5hKPtp8BKxIRUJaYfG86M0gRs8BiFokD7z6AJYQF
 zCR27F4K1sAioCpxfMJjsDivgLPE8xf7oDbIS0xb3QUVF5Q4OfMJC4jNDBRv3jqbeQIj3ywk
 qVlIUgsYmVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERta2Yz+37GDsehd8iFGAg1GJhzfh
 gmuMEGtiWXFl7iFGCQ5mJRFe14tuMUK8KYmVValF+fFFpTmpxYcYTYGOncgsJZqcD4z6vJJ4
 Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjNVKlpv+HljFFuaYfnrC
 5jk7Dm3ru1H10i4m8NbPY5t2Hz47+2L+dIePZgrSomJb/GcdPHP5xkZLB6cFpjta2GLWu3ob
 8rx96pO/0nShk86PRa6FszV0/f5nPYw/Kc9vUnbYrfbmZqkIAU1VS+Z1unvOfzoxRToy7+pc
 ydUGgRJT9x5100r4wabEUpyRaKjFXFScCACM4EHawgIAAA==
X-CMS-MailID: 20190122152607eucas1p2c58a7814bb9ab72cc46d5a84eb1962a4
X-Msg-Generator: CA
X-RootMTR: 20190122152607eucas1p2c58a7814bb9ab72cc46d5a84eb1962a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122152607eucas1p2c58a7814bb9ab72cc46d5a84eb1962a4
References: <CGME20190122152607eucas1p2c58a7814bb9ab72cc46d5a84eb1962a4@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_072611_766612_F93D2657 
X-CRM114-Status: GOOD (  11.39  )
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

Kamil Konieczny (3):
  arm64: dts: exynos: add SlimSSS for Exynos5433
  dt-bindings: crypto: document Exynos5433 SlimSSS
  crypto: s5p: add AES support for Exynos5433

 .../bindings/crypto/samsung-sss.txt           | 13 +++--
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  9 ++++
 drivers/crypto/s5p-sss.c                      | 50 +++++++++++++++++--
 3 files changed, 65 insertions(+), 7 deletions(-)

-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
