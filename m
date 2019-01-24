Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:45:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B6321872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DR0Vvc1W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fopoulaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B6321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=W71e8nf0505a8GHZi5ln4Z8PmZgbX8DXkoD1cXAT3Pc=; b=DR0Vvc1WjV4DYA
	JszlVq6Rn1npcU2HuCcF3QspBtbx7uNSrALuz2+xfgSOV1Osh8T/vKRRbcy3tfKwjdequ9uFdNqTH
	0DE9YtgMVu+niRWeT97Snx7t6JtbkzMxMwSIO5RYzQePNyNGD0PoN2xlZoNHcoOh/urHh5WTp7/oM
	mzxH5wizvO6iH3fw91z/t6Lywo9691C7b98IcFMSwMjODmyYfFW+mB6ttHK7QqzFkCMtsomipmINF
	75QaLUu9jdaYxwY+xOqLZEs8Ha5qwV+PhPNZmqNvRZUZ+skF/e6VZmALAqdCR+Cv9TETGuYW4dzwV
	HFm2wB6RIyMHTSbpUK3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhCM-0000eD-NY; Thu, 24 Jan 2019 15:45:46 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhCI-0000dX-V5
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:45:45 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190124154540euoutp023b100b4d889958aaee4f04f336278a03~801Zq2ZfR1726317263euoutp02a
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 15:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190124154540euoutp023b100b4d889958aaee4f04f336278a03~801Zq2ZfR1726317263euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548344740;
 bh=/xQzUe1GHbNvEygIbIWpOEY0rI+f8gn66bnkBqO7RWE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=FopoulafwqgZETWNA10pnlp6HNJ34ak/O6P/AVZuQMiue9XLu9W6ZtzXZ9Vmvn/pP
 9ZuC9wuZS1/anv6ztC4ehhC4h4/AC5O9pa5/hRF0Yc5QpR9cECnSMc+QBL0OprlAP1
 RYBdcH+pwpkQKCm9smw+UIC53q7+g4T4qCrmnv7g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190124154538eucas1p2458e0c48b348536c983cdc8b80566cbe~801Yp2-5_0298402984eucas1p2x;
 Thu, 24 Jan 2019 15:45:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 67.25.04441.2ADD94C5; Thu, 24
 Jan 2019 15:45:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190124154538eucas1p17664bc2380e0d458b9ab33f79e55e810~801X4C_oR0082100821eucas1p1q;
 Thu, 24 Jan 2019 15:45:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190124154537eusmtrp1f9967cf7f88b8c50a3f2c0fdd1ade2a1~801XpKUlE0583105831eusmtrp1c;
 Thu, 24 Jan 2019 15:45:37 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c1-5c49dda268ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.9F.04128.1ADD94C5; Thu, 24
 Jan 2019 15:45:37 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190124154536eusmtip20871651ce915b9250dde2dfa7835bae6~801WrJu6-2591025910eusmtip2n;
 Thu, 24 Jan 2019 15:45:36 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v3 0/3] add AES support for Exynos5433
Date: Thu, 24 Jan 2019 16:45:18 +0100
Message-Id: <20190124154521.13589-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRjv+77v3fu6dXodmydMda1arcjW6lukWrJXq6Y/qq2orrxhcXTn
 R/IHDc2PkqUhSVhUiHN+NUq5lKTuphanhkbzh5YKiZu53L2U/z7P5/N8nl97GFLWK3JiQpVR
 vEqpCJOLJVTDq2n9ppI+v4DNrfp1uCavWoQLDMkUvtumF+GMERec2WJG+PrQNxIbDBoaa4e6
 RXigf5rAH5oKxDjP0ELgR219NC7t6SJwytM2GptNSeTuZVxlYSXi6h72ElzD8zWctjxNzNXe
 S+Bmi29SXOvoE4LLrCtH3LjW1d/muMQriA8LjeFV7t6nJSGjZdepyHb6YkrfIJ2IpkXpyIYB
 dgv0DxjF6UjCyNgHCCpeFxJCMIEgeaIfCcE4Ao3pPblgqU2rpQThPoLHmgryn6XvxyyyZInZ
 bTDY+JawYAd2NWT351qTSDaXAuPUbdoi2LNb4Zf5hRVT7BrQpaZRFixlfaChvIcS2q2AnIp0
 QuDtoOPWVytPzvFJ9betRYF9Q0NOSjUSDD6QOdUtFrA9jLTX0QJ2gc7sq/NFY6G5fpgWzMkI
 7mSXEILgCS/au+Zuw8x1WA/VTe4CvQdSJk2EhQbWFozf7YQZbOFGg2UxCy2F1CsyIXsTFJrf
 zh/YGdLNVfOYg5phvXUyGRsIBW+KUBZamb9os/xFm+X/n6EIkeXIkY9Whwfzag8lH+umVoSr
 o5XBbmcjwrVo7uE6Z9vHHqPf78/oEMsg+VJpqs4vQCZSxKjjwnUIGFLuIN3X5RsgkwYp4i7x
 qohTqugwXq1Dzgwld5TGL/lyQsYGK6L48zwfyasWVIKxcUpER/9cyzpSf3KV9pnjxtL9w836
 nz8dzNvrU0cMZY1F/Nq9RZ/lYlcPTe3Bd3XGKmVCt3YnccC7Ax+TpM1cdjd+8tTgLtmBwxmm
 u45x1S8PLd/xSzrlHrAy3tf/Y1txXmeUhzQ+9FzgLoeX4GVb8Gpm6QVvn5mZ2Q9lHyfHKhVm
 1VY/OaUOUXhsIFVqxV/ML7erbAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7oL73rGGDxdq2exccZ6Vos551tY
 LOYfOcdq0f1KxqJv339Gi/7Hr5ktzp/fwG6x6fE1Vov7934yWVzeNYfNYsb5fUwWa4/cZbdY
 ev0ik0Xr3iPsFv9/NTM78HusmbeG0WPLyptMHtsOqHpsWtXJ5rF5Sb3Hv4VTWDwOvtvD5NG3
 ZRWjx+dNcgGcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWp
 Rfp2CXoZ75b1sxQcZ69ovfuIvYHxJ2sXIyeHhICJxObOzSxdjFwcQgJLGSVWTj3FBJGQlmg8
 vRrKFpb4c62LDaLoE6NE4/srbCAJNgFziUfbz4AViQgoS0y+N50ZpIhZYDGLxIF3H8ASwgJm
 Eh//H2YHsVkEVCUOdXSygNi8Ai4S21ZdZ4HYIC8xbXUXE0RcUOLkzCdgcWagePPW2cwTGPlm
 IUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCyth37uWUHY9e74EOMAhyMSjy8
 HYc8Y4RYE8uKK3MPMUpwMCuJ8LpedIsR4k1JrKxKLcqPLyrNSS0+xGgKdOxEZinR5Hxg1OeV
 xBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDMcemx1RDfxOVg99s1
 OK3g2P4KvqlTFzhdW5qyYwbPl5W1ATyOrGJ1qW5xjTtKun8arzsTnGv0/6M7Z/eM35l2Tqfu
 tN9h19Y/d9O483xAlOGdT6cePj88T0f4yWEbDq9D1msbmyd8sboipXjzfO/sX48nzJqQcHJN
 83r3bNtjcz8oWH35E+uuxFKckWioxVxUnAgAXT6g1MICAAA=
X-CMS-MailID: 20190124154538eucas1p17664bc2380e0d458b9ab33f79e55e810
X-Msg-Generator: CA
X-RootMTR: 20190124154538eucas1p17664bc2380e0d458b9ab33f79e55e810
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190124154538eucas1p17664bc2380e0d458b9ab33f79e55e810
References: <CGME20190124154538eucas1p17664bc2380e0d458b9ab33f79e55e810@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_074543_302002_503AADF9 
X-CRM114-Status: GOOD (  12.98  )
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

Changes since v2:
- address Corentine Labbe note: add "const" to char* in declaration of
  struct samsung_aes_variant

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
