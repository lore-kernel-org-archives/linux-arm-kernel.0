Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B24C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EE82192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kf34lw10";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="joe1NdsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EE82192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-reply-to:Message-id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=97BxDP5X8T7a4xao4GiakLYgdJi9MS8cw1YbmBg6iEs=; b=Kf34lw10DHoZJB6Eue+atGH2rF
	rSrwRUQwd0qvO6xHm/KcfpHnhZivbU4/v65BkVfHzivwFIJXqMypXfre3nZYKdJXTa4GDNQz+TnT6
	BmS+If7gBSVD1A1LG1tjLsaf1Zev/E3uYS4Frq+5uYjtsvEjktVc+8CqxAsqOA5iGJ6hfMeNUJLYj
	WtKUEVTldpRioTESqaXjpMuAkEIhXkn4YMfvAxT8OtRsA6RSYBcPwrmgKApgR1t9loNSSn7YzKLMG
	SHd2QDYbfzNv00t7n/lz/jVT3iPhACgnIVdrb25iJVHgq65TSiXkqnYZ2ENtgfyM0Z9c83kC5L6zV
	pk9xjCEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guczd-0006mE-HO; Fri, 15 Feb 2019 12:53:25 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucyy-00062c-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:52:48 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215125240euoutp02701be4b2fce5411ccec11c06c50e9465~DiqotMKkL0872408724euoutp02c;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190215125240euoutp02701be4b2fce5411ccec11c06c50e9465~DiqotMKkL0872408724euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550235160;
 bh=zJetpoNhW01GT4Xt0gk6SKTpHAA/tdY/kH9zyQ9f4Ok=;
 h=From:To:Cc:Subject:Date:In-reply-to:References:From;
 b=joe1NdsNzFePlq2+c75p3x1d365Id9YcxVSljweKfbeAUF+idVgjiCj70lIGnuxfN
 PKO9B8Ge9grY9EW5B2FOw0CuZH9Ds8Aod0bssXHXbo9YltTjpOoVgstnNBQv3tsRPr
 ihjjk0ZBnHI0IP2pNntB1+5mDeFfSayXFBHWSMwk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125239eucas1p2acb240ec49a4f2e1116d642ec0efa336~DiqoV1EST0666006660eucas1p2q;
 Fri, 15 Feb 2019 12:52:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.35.04441.716B66C5; Fri, 15
 Feb 2019 12:52:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125238eucas1p28bd5cebc6d61da7b25e4cca396b6e35e~DiqngZpNi2424824248eucas1p2d;
 Fri, 15 Feb 2019 12:52:38 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-5b-5c66b617fc66
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.10.04284.616B66C5; Fri, 15
 Feb 2019 12:52:38 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY00LS8X3MCB70@eusync4.samsung.com>;
 Fri, 15 Feb 2019 12:52:38 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] clocksource: exynos_mct: Remove dead code
Date: Fri, 15 Feb 2019 13:52:25 +0100
Message-id: <20190215125229.30180-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190215125229.30180-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7djP87ri29JiDBbfVrTYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBm7VtkWTOar2NPYwNbA+JC7i5GTQ0LARGLPk9lM
 XYxcHEICKxgl7rd/ZYNwPjNK/L89jwWmasX9DewQiWWMEi/3bGGEcBqYJPbPfcYEUsUmYCjR
 9baLDcQWEfCWmHzmL1gHs0AXk8TthQfYQRLCAnYSn9avARvLIqAq0X3wB1gzr4CtxOH575kg
 1slLrN5wgBnE5gSqX7OmhxlkkITABDaJlW0HgTZwADkuEmu3ukLUy0h0dhxkgqhpZpRonzGL
 HcLpYZTYOmcHG0SVtcTh4xdZQWxmAT6JSdumM0MM4pXoaBOCKPGQOPrsMDPEaxMZJSYtfsg8
 gVFiASPDKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDYO/3v+KcdjF8vJR1iFOBgVOLh
 XZGRGiPEmlhWXJl7iFGCg1lJhJdzTVqMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLp
 iSWp2ampBalFMFkmDk6pBkbtRUs8PoTpFtWxlDRG3bssItDk7i6wp4K/5OyTvoC5/p1t6ZxL
 ggO3VCx9IW0yyV+u1Xd5xlMbBtWkHVPfX2KetsH42JKpd9kij5rV1//tWn0qqGjqiWD7N/t5
 7x3WZ7PQ83NQ7RDUlImvkb51L/LeFYZzyZGc3l/WCdsvM7OsYLJLvZPSrcRSnJFoqMVcVJwI
 AMbKBCO5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e/4NV2xbWkxBjMfWVpsnLGe1eL6l+es
 FvM+y1qcP7+B3WLT42usFjPO72OyWHvkLrvF5k1TmR04PDat6mTzuHNtD5vHu3Pn2D02L6n3
 6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroxdq2wLJvNV7GlsYGtgfMjdxcjJISFgIrHi/gb2
 LkYuDiGBJYwSM089YYFwmpgkNv69wgpSxSZgKNH1tosNxBYR8JaYfOYvWAezQA+TRPvV3+wg
 CWEBO4lP69ewgNgsAqoS3Qd/MIHYvAK2Eofnv2eCWCcvsXrDAWYQmxOofs2aHjBbCKjm8qoH
 jBMYeRYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIDKZtx35u3sF4aWPwIUYBDkYlHt4V
 GakxQqyJZcWVuYcYJTiYlUR4OdekxQjxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5Y
 kpqdmlqQWgSTZeLglGpg5N0v2fP1+JTbrBcvXuOrDHlmsnbazs9/aldpyu0/Oe2d62aGFpOD
 4q3Hgtp+s7yNb3wTYt7Su4+na/F9+9N3jFZ5fFmxQMZHN2o528Z9OerKe79nZKip+kgLHLC/
 bz6hSelTgmNeo6/Wmur0K++nrZL033NC9HefilbEX0mjz4b/z+V6hc76rMRSnJFoqMVcVJwI
 ACgRew8iAgAA
X-CMS-MailID: 20190215125238eucas1p28bd5cebc6d61da7b25e4cca396b6e35e
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125238eucas1p28bd5cebc6d61da7b25e4cca396b6e35e
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125238eucas1p28bd5cebc6d61da7b25e4cca396b6e35e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_045245_003833_D5B8722B 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0. Device node pointer is always provided when driver
has been probed from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..ef18bbf8d20c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -507,13 +507,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
-	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
-				clk_get(NULL, "fin_pll");
+	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
-	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	mct_clk = of_clk_get_by_name(np, "mct");
 	if (IS_ERR(mct_clk))
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
@@ -581,11 +580,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
