Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F1C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACBF2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATCo8/p1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vHxH3S7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACBF2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/BujKfEsBNtbst+3VgrGCX4tED+78Y++lyp1qpQsaGg=; b=ATCo8/p12ljkkFeqv+2ucaQVIz
	CXfXAH86hBm7JyaVKOYRtjQWs8Lols/O4kpGxd9/J7aafAJPdxfAUGN3N5kS3zHrpJnct029I9xxg
	UnkXxi+1lqSHrNTtE2Pcf1gWqoLMdM43nstRV3Ks8CkXuVF0/OFaYpLlxwS4hLep978C0usFH7RZP
	atH+uyRPgScjJEi6QnDc2hexYywbDQ92PIYQu2XbQ39RvAOxwvUq5kKO5Stxeb5rYjB6MW0l9OBWs
	OC0teec9OcpQUD5S/iP3vl6OJfvxvdAWSRWN+4jRfyuTLIVxYRpGZD7nr6DWTLXlN1d/x6+SxxsYU
	nVKH6qtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCU2-0004Wf-RI; Mon, 28 Jan 2019 19:22:14 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCTm-0004Jc-Gh
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:22:00 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190128192152euoutp02d96721812412144141e7b15fd41ab64c~_GXUevccJ2531425314euoutp02Q
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190128192152euoutp02d96721812412144141e7b15fd41ab64c~_GXUevccJ2531425314euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548703312;
 bh=gwLpP+fJxTXiUYPFk84WkmAXe+Yg2TY9OIz8w3v3/E8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vHxH3S7zOEUvXw18czBIzoBlCa5EsUQW1njYCSc5C3Qhhk4BQywY5eoe8aIds60WN
 13a09/gjAF1goiz4RcnhOYhX/5mupmZNJ/S+EDszi5/efh/AvqBUg4owpkvqoeBcWh
 BxxFzP+3SopWvT2APgIyWGakOSfjiO+fSI4x/xDo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190128192152eucas1p2c454e5d3852250b45f2d70d6fc92eb80~_GXT8bLp30030000300eucas1p2u;
 Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.C5.04294.F465F4C5; Mon, 28
 Jan 2019 19:21:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96~_GXTFkPPE0392103921eucas1p1R;
 Mon, 28 Jan 2019 19:21:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190128192150eusmtrp195cadf4a98757e4452534a142e365988~_GXS23PRP2976329763eusmtrp1K;
 Mon, 28 Jan 2019 19:21:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-97-5c4f564f7f82
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.F8.04284.E465F4C5; Mon, 28
 Jan 2019 19:21:50 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192150eusmtip1b24278debb2da6af81d1826be48a127d~_GXSMyDbO0091700917eusmtip1Z;
 Mon, 28 Jan 2019 19:21:50 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 1/8] clk: samsung: add needed IDs for DMC clocks in Exynos5420
Date: Mon, 28 Jan 2019 20:21:32 +0100
Message-Id: <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7r+Yf4xBlPuGFtsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7Ba3GmQsNj2+xmpxedccNosZ5/cxWSy9fpHJ4nbjCjaL1r1H2C0O
 v2lndeD1WDNvDaPHplWdbB6bl9R7HHy3h8mjb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4MlZM
 X8FesFqw4sems8wNjHf4uhg5OSQETCS2nv/K1sXIxSEksIJR4sy934wQzhdGiZOvPrFAOJ8Z
 JdbcWM7excgB1jL5Jz9EfDmjxKHpc1hARoF1fP7GBFLDJqAnsWNVIUhYREBO4ubXu2AbmAVm
 M0tM3/WJDSQhLBAgMfvnDmYQm0VAVeL8rOdgcV4BL4mzh9azQJwH1HyuE6yGU8Bb4nTfArDr
 JAQWsUtM7TvJBnGQi8S+c1D1whKvjm9hh7BlJE5P7oGKF0uc7VjFBmHXSLSf3AFVYy1x+PhF
 VpAxzAKaEut36UOEHSXOz78P9S6fxI23giBhZiBz0rbpzBBhXomONiGIag2JLT0XmCBsMYnl
 a6ZBDfeQWDGpGRqC8xgl1r25wjSBUX4WwrIFjIyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLz
 czcxAhPM6X/Hv+xg3PUn6RCjAAejEg+vAZt/jBBrYllxZe4hRgkOZiUR3qnX/WKEeFMSK6tS
 i/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MLpdVjqZ2/DpoNz30Pef
 TiTbpm8PrHfQOC26/9uB80yPQr8tviq/Sfasa++B3b6TFN9L7a+OXhI7tfVLaX5325eHCUcv
 uYtal+yeflzhcBNz2dqdnJqLT8wS8vmWmfE94je/e929jxp1F6ZXXttnHhFiJrXyoWUl84c0
 HpeLNh9XqS2R8d7Sxq/EUpyRaKjFXFScCAAcucoxLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xu7p+Yf4xBssXG1psnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7Ba3GmQsNj2+xmpxedccNosZ5/cxWSy9fpHJ4nbjCjaL1r1H2C0O
 v2lndeD1WDNvDaPHplWdbB6bl9R7HHy3h8mjb8sqRo/Pm+QC2KL0bIryS0tSFTLyi0tslaIN
 LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MlZMX8FesFqw4sems8wNjHf4uhg5
 OCQETCQm/+TvYuTiEBJYyiixYs85xi5GTqC4mMSkfdvZIWxhiT/Xutggij4xSqz+MZMdpJlN
 QE9ix6pCkBoRATmJm1/vgtUwCyxnlpi79gIbSEJYwE/i2fQWVhCbRUBV4vys52BxXgEvibOH
 1rNALABqPtfJDGJzCnhLnO5bAHaEEFDN9MkvWCYw8i1gZFjFKJJaWpybnltsqFecmFtcmpeu
 l5yfu4kRGPTbjv3cvIPx0sbgQ4wCHIxKPLwGbP4xQqyJZcWVuYcYJTiYlUR4p173ixHiTUms
 rEotyo8vKs1JLT7EaAp01ERmKdHkfGBE5pXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnN
 Tk0tSC2C6WPi4JRqYCw+YbvrvXWTqufrt2dvr1Xw199yen114o8DPS9eKn1+Y9XE1iu4cZVK
 oaLihJCgxnzhwwqiZx9dT36oU202wd97R01b58MZnp+kLszWf6YQv+prCO/fD/V3fx6sc3pu
 9HXBg8gQ+6KjHIqB+rb8rIeaj96MqJCXnRYqaemzS9fra6hB33wXeyWW4oxEQy3mouJEAHg2
 2n2QAgAA
X-CMS-MailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
X-Msg-Generator: CA
X-RootMTR: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_112158_747166_2505BD6F 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, b.zolnierkie@samsung.com,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 myungjoo.ham@samsung.com, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469..1827a64 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -60,6 +60,7 @@
 #define CLK_MAU_EPLL		159
 #define CLK_SCLK_HSIC_12M	160
 #define CLK_SCLK_MPHY_IXTAL24	161
+#define CLK_SCLK_BPLL		162
 
 /* gate clocks */
 #define CLK_UART0		257
@@ -195,6 +196,16 @@
 #define CLK_ACLK432_CAM		518
 #define CLK_ACLK_FL1550_CAM	519
 #define CLK_ACLK550_CAM		520
+#define CLK_CLKM_PHY0		521
+#define CLK_CLKM_PHY1		522
+#define CLK_ACLK_PPMU_DREX0_0	523
+#define CLK_ACLK_PPMU_DREX0_1	524
+#define CLK_ACLK_PPMU_DREX1_0	525
+#define CLK_ACLK_PPMU_DREX1_1	526
+#define CLK_PCLK_PPMU_DREX0_0	527
+#define CLK_PCLK_PPMU_DREX0_1	528
+#define CLK_PCLK_PPMU_DREX1_0	529
+#define CLK_PCLK_PPMU_DREX1_1	530
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
@@ -217,6 +228,10 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_DPLL		660
+#define CLK_MOUT_ACLK_G3D	661
+#define CLK_MOUT_SCLK_SPLL	662
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	663
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +263,9 @@
 #define CLK_DOUT_CCLK_DREX0	794
 #define CLK_DOUT_CLK2X_PHY0	795
 #define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_FF_DOUT_SPLL2	797
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		798
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
