Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD4C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF4E218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g/zmqV6f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KJx2Kd4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF4E218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=78jKG8WOWTUrAynP0SOmdApPDKGkh3LQAJkju9C9s4o=; b=g/zmqV6fvk6RPZrVXTacQ2gA9f
	rKz/nm+k05jLv2Ncm+7rr0jbxg8mB6W1EyrlSzV6lqTd4l/PyutIhPll3FRBYn4XvBJ/bJ2W+r27H
	d5uynglWpfEN25mUAjt9OWOuOKE4xTY69DLKeqyBGZUtcj4L5u2xS/0b/wwgzjBmf+2c15S/tXz4T
	O2i6gFvxyia3bdM+i8e85Ym7E19z5GimvpgbldFn8clRU/0Gmn4djPRyz2ucTxFi6cqTDCL+mWcFL
	d8958zMApLmxlg26pZr1N4PNJ1um2pHvM7eaWeFQnSFF1F34/o0W2J7OAHGfCG9q3tTTDgBFleQK7
	Wk98lnFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbyc-0004JZ-3h; Fri, 01 Feb 2019 16:47:38 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbyM-00045t-RL
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:47:25 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201164721euoutp01ad91417020aca6485123e2e8b21bf730~-S1i6fUf01936319363euoutp01-
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 16:47:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190201164721euoutp01ad91417020aca6485123e2e8b21bf730~-S1i6fUf01936319363euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549039641;
 bh=LJ6kHZLte9DLFMXprZYBL14Bih1PDOVf0r+InbD85tM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KJx2Kd4uYxes6ChlrURdAebRjz8rM86iZBFjYX7Ov2aUg9bOYwAKA46/Ucp7Arnpd
 tZpSEGG0zI8uoRKfH6mKsHjLiZRr8Qv6g9FUvLqbv+HeIqZ9xELged1IFHp9U8VxWa
 D09ADbSR5QYc5HLsOeEhzP2Re5uFF7c3r/EEQrDY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190201164720eucas1p1f9e3836e447ad4639cdfa5ccb9374091~-S1iUNk120638706387eucas1p1G;
 Fri,  1 Feb 2019 16:47:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 0D.E3.04441.818745C5; Fri,  1
 Feb 2019 16:47:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190201164719eucas1p106c8761eb4bff12a906b601a37bf58b5~-S1hUeCG40638706387eucas1p1F;
 Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190201164719eusmtrp147a31e880ea6315067c99c535b59c038~-S1hFTL473167231672eusmtrp1W;
 Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-d4-5c547818d090
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.30.04128.718745C5; Fri,  1
 Feb 2019 16:47:19 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190201164718eusmtip21477efa61b1f73e99d3fb8ed84c342e1~-S1gVrtP23272832728eusmtip2k;
 Fri,  1 Feb 2019 16:47:18 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
Date: Fri,  1 Feb 2019 17:46:47 +0100
Message-Id: <1549039612-28905-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUgUYRjum9nZHa2RcTV9yaPYEDRwtQz6yCizazAqC4tQIdecPFKzHS2z
 yCNLE9Ol09QyxFC2wmutRcrQzCPzDq202FpCsExqV8ooq3E2+vd8z/E+Ly8fTSrvUkvo+ORU
 XpusSVTJ7WX3O2b7fCE9LNLf9MsJ15fUUnjUOkHhivY+ChebP5K4v79OgXtzPinw6yx33GAe
 ofCXwrcUHm4ul2PLhXaES/pbCHyv/Y0CDz7bgseya+T4yac8Cs+N1MuCHLnpl2cVXIP+vJxr
 rMrkWj8/JLgigx5xlgbPUHm4/boYPjH+GK/1Wx9lHzdlMaKUVof08sq9WahpUQGyo4FdDVND
 TUQBsqeVbA2C7O5hSnpYEVQVGW2KBcHT11bZv0iloV4uCdUIZoZKFaIwHxnRaQsQTctZNRj1
 R0XamT0J46OPSdFPslkkGHN084Oc2F0w1pVHiFjGekFusYUUswwbAq2TAVKXJ7zqO0+K2I7d
 DvnmB0icA2yLAkwDE0gybYbRB+JCInaCyU6DQsLu0HOp0La0AL35epvnFOR1G22eQHjSOUiJ
 vSTrA7XNfhK9ERrvDBEiDawDvJxyFGnyL7x4/xop0Qzkn1NKbm8wFA4QEnaB6rtXbcM5KDM0
 2e55E8HX3m5Ch5aW/i+7hZAeufJpQlIsL6xM5o+rBU2SkJYcqz54JKkB/f1DPXOdX41oZii6
 DbE0Ui1i6n7siVRSmmPCiaQ2BDSpcmaCE8IilUyM5kQGrz1yQJuWyAttyI2WqVyZkwtMEUo2
 VpPKH+b5FF77TyVouyVZSH8drf+9rf6K7HZCQWVmR+iswb3McxCWW8PXqN8x/p2P4LTbN2v0
 DaZ6a+XqoE2YC6paXJHDfIza3+gSGTGbml17JeRM8HSA17KF7wfX/uzKHfeRu4ztPNQ9Z973
 PW4Hd2HMP/qF924PX517jseqD6d2mE3KyyOBhK6PS8vY8FytkglxmpUrSK2g+QPx2eqqPwMA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4PV3xipAYg21tfBYbZ6xntbj+5Tmr
 xfwj51gt+h+/ZrY4f34Du8XZpjfsFrcaZCw2Pb7GavGx5x6rxeVdc9gsPvceYbSYcX4fk8Xa
 I3fZLS6ecrW43biCzeLwm3ZWi3/XNrI4CHq8v9HK7rFpVSebx+Yl9R4H3+1h8ujbsorR4/Mm
 uQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M
 t593MBYc5KuYsyi0gXErTxcjJ4eEgInEoi0b2boYuTiEBJYySlz9dosdIiEmMWnfdihbWOLP
 tS6ook+MEstXfWHtYuTgYBPQk9ixqhCkRkSgXqL/zSWwGmaBPmaJxuOLWUESwgK+Eo+nfWIB
 sVkEVCVa+j8zg/TyCnhJHHxlDDFfTuLmuU5mEJtTwFui4/F2RhBbCKhk1b8DzBMY+RYwMqxi
 FEktLc5Nzy020itOzC0uzUvXS87P3cQIjIxtx35u2cHY9S74EKMAB6MSD++GX0ExQqyJZcWV
 uYcYJTiYlUR4nbJCYoR4UxIrq1KL8uOLSnNSiw8xmgLdNJFZSjQ5Hxi1eSXxhqaG5haWhubG
 5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGGP/3Lmjpe785bPERu8Nsi8U5B/P+aEW
 2jAhgEPS9dTM4tuR3d9ufQt6+3HWsi985q6LEv5nXLPsCWXeEr0++nSna/bHhR8LrszvlOLa
 9y/wnqH+YZ1PzAdiNl31/Zt0du/SCTwxpmfXTBS5GP6mZvfMMrbXmWZXohfsXHPQaOWfwMe3
 zh5qifmgxFKckWioxVxUnAgAsp6ClaICAAA=
X-CMS-MailID: 20190201164719eucas1p106c8761eb4bff12a906b601a37bf58b5
X-Msg-Generator: CA
X-RootMTR: 20190201164719eucas1p106c8761eb4bff12a906b601a37bf58b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164719eucas1p106c8761eb4bff12a906b601a37bf58b5
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190201164719eucas1p106c8761eb4bff12a906b601a37bf58b5@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_084723_199229_85F9244C 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: b.zolnierkie@samsung.com, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, cw00.choi@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, myungjoo.ham@samsung.com,
 s.nawrocki@samsung.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index f1a4f56..1fc5152 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1323,6 +1323,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1465,7 +1476,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
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
