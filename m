Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F5C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:23:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CAA2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qh1ZxtoD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JjErbxcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CAA2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PTWT+sC5C1Vn35rEtPAgCRQXTXKQAekQmB9N6shE/n8=; b=qh1ZxtoD0K1hBqDWcqIqvNAF8w
	SIeAmJKtgrR3DLxwcOstaAQ4qhKgNv83eN42pfldEZcF0/NRjgd3BI8Smqc8LrMm02ipNplRSj/9/
	XC4+Z7EUCCbXc4GOoWHhyKgR1Bajzk3Df3F2CEqhOToGqcm7Y6LZrYBTHhhuF6C96GU+KU4fWHTNg
	9E18gkVmedEPWEUMmAxLcX/S3VEyd2gOqvWimiw8+2WzCIaxdgYEIqK0mRFcJrT9/wuVNmNmRWB8c
	0t5AVhVEeIuXNee1DtdHwdvYifky5XaubWtgycEn7uh+CKiQxxew/e6h4VxeJKd6E1KLB4s+pXr81
	tA1NhVZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCV5-0005Kt-3f; Mon, 28 Jan 2019 19:23:19 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCTm-0004Jf-Gf
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:22:04 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190128192153euoutp012902ae0057af08e14222a99936dc10ea~_GXVnqTYg2839628396euoutp01d
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190128192153euoutp012902ae0057af08e14222a99936dc10ea~_GXVnqTYg2839628396euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548703313;
 bh=gAM5TRktEeGRdR7DfQ1QhDkjvwroBHzBH5M4lKDBh1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JjErbxcPWS+wKv/v7o34saT1PRk1RlmC59TBks7yOKF3gJp1vBsgFwqXGWS04PfB/
 qck6vEa+dS6bqymZ9kRLLCtDOyIoMQ08RSIqsiOZGeCEGm3aylZmXcrRvcPoplxBfv
 m+tyOKYMnIWRwJJOjVWlyjSn6Hcq4k/CKINbsado=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190128192153eucas1p1474757b8d86fd1b0ad21385942c04a9d~_GXVHWmEb0389603896eucas1p1O;
 Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.0F.04441.0565F4C5; Mon, 28
 Jan 2019 19:21:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192152eucas1p118c23cce7c1f6d9a961cba8ae8304318~_GXUNph8e1734117341eucas1p1k;
 Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190128192152eusmtrp1c36f8112cd44652755dddf07f4d4230e~_GXT_cToi2976329763eusmtrp1M;
 Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-9d-5c4f565019b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.F8.04284.0565F4C5; Mon, 28
 Jan 2019 19:21:52 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192151eusmtip1687df5aacacd72b7b4eb354b6d839eae~_GXTV7cV50041400414eusmtip1P;
 Mon, 28 Jan 2019 19:21:51 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
Date: Mon, 28 Jan 2019 20:21:34 +0100
Message-Id: <1548703299-15806-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87qBYf4xBgtWMFpsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7Ba3GmQsNj2+xmrxseceq8XlXXPYLGac38dkcfGUq8XtxhVsFoff
 tLNa/Lu2kcWBz+P9jVZ2j02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBFcdmkpOZklqUW6dsl
 cGXs3f2HpWCHUMWGXS3sDYwf+LsYOTkkBEwkJn2dydLFyMUhJLCCUWLdqSfMEM4XRontj5cy
 QTifGSU2bOkAynCAtcz+IQURX84osa/3BCtcx6uuJUwgRWwCehI7VhWCrBARkJO4+fUuG0gN
 s8B+Zon9syexgCSEBbwk7k17xghiswioSjQcegEW5wWKr29dyQ5xH1DzuU5mEJtTwFvidN8C
 RpBBEgLL2CXetv6AKnKRWH3pCRuELSzx6vgWqLiMxOnJPSwQdrHE2Y5VUDU1Eu0nd0DVWEsc
 Pn6RFeRoZgFNifW79CHCjhKbp69hg3iYT+LGW0GQMDOQOWnbdGg48Ep0tAlBVGtIbOm5wARh
 i0ksXzMNariHxJJ/96BhOI9R4tOnNuYJjPKzEJYtYGRcxSieWlqcm55abJiXWq5XnJhbXJqX
 rpecn7uJEZhsTv87/mkH49dLSYcYBTgYlXh4Ddj8Y4RYE8uKK3MPMUpwMCuJ8E697hcjxJuS
 WFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJg1OqgdGy9N7B6ypz+uaX
 +0l8v3FzS+ec4Hm3bvLXXpgc/TXUO2Vq5EsGSxeG70lT3Pr/Z99ZIfL81bML5i/KlP8fOX7V
 sDx2L8ODFd6bLhizlGzPykhRi1glP3Xjpdkbp5l/SEhx91jtPitRnuvoXfXKN/9jfHbpfQvm
 LM9qKXN14Ge0ejAtYMUSRwElluKMREMt5qLiRADjLC6hMgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Xd2AMP8YgxtzmS02zljPanH9y3NW
 i/lHzrFa9D9+zWxx/vwGdotbDTIWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1eJ24wo2i8Nv
 2lkt/l3byOLA5/H+Riu7x6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii9GyK8ktLUhUy8otL
 bJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL27v7DUrBDqGLDrhb2BsYP
 /F2MHBwSAiYSs39IdTFycggJLGWUuHJEDsSWEBCTmLRvOzuELSzx51oXWxcjF1DNJ0aJ3X8v
 soL0sgnoSexYVQhSIyIgJ3Hz612wGmaB08wSux78YQFJCAt4Sdyb9owRxGYRUJVoOPQCLM4L
 FF/fuhJqAVDzuU5mEJtTwFvidN8CRoiDvCSmT37BMoGRbwEjwypGkdTS4tz03GJDveLE3OLS
 vHS95PzcTYzA0N927OfmHYyXNgYfYhTgYFTi4TVg848RYk0sK67MPcQowcGsJMI79bpfjBBv
 SmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbnA+MyryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpi
 SWp2ampBahFMHxMHp1QD48TaE3bXLh7gEDOZ1P809fatqweZaqJrEz5qn1rUo3xtW+1h4cee
 uStbTCfZSQrVbN6Q/l7vgx1fgbu645VXtVYW7Bpn2Df0eqbLtR4oMBdp2CxY7H+QMfVp2vw0
 m5cuZyQ6LCI5T5w02X5dxivq0439U7wEZus//aV78/qVxIc/HdbHqDAsVWIpzkg01GIuKk4E
 AAxFRQmTAgAA
X-CMS-MailID: 20190128192152eucas1p118c23cce7c1f6d9a961cba8ae8304318
X-Msg-Generator: CA
X-RootMTR: 20190128192152eucas1p118c23cce7c1f6d9a961cba8ae8304318
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192152eucas1p118c23cce7c1f6d9a961cba8ae8304318
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190128192152eucas1p118c23cce7c1f6d9a961cba8ae8304318@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_112158_751541_10ABB6B6 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 myungjoo.ham@samsung.com, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: linux-clk@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 3e87421..8bf9579 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+	PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
