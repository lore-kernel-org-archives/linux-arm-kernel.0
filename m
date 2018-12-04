Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BF1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F9A2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qqpb2jj5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XAv3vxt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F9A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cna5m+x63GLUa0XcAv+Lp794QRHml30EDnDEPF4ccQ8=; b=Qqpb2jj5CcnABo
	NlbUx4beoNo/h2IQH+QMOMkgYzOIMNorLrzQZyY6/wVN4It5p6kIVYDGW2j1x99OebwVCZL3QBpvE
	IUabHYIzFn54CXmWXFtVthSs4J7ni/XwCB/aNNVYRursTOlRvMHdUo9xNV+dg/Jl8QtOk/Q3UX9fn
	UMGPjpenj50dD/QwW5NIBq7ImQ8l6ghMFwXcTEGDL4B8Oa1ki3oiyYyLSaawbAvnrmHp9TFY/xedk
	/rSIWxsD4kKBzPC5jMblCbN7tzC+MeAi5lgELjE/uoMIAIGLs/rOyIAU43Wsjir94ligb5MnnUbA9
	vYIYTD1Zecu4xzcSxv3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDxF-0002Gx-9x; Tue, 04 Dec 2018 16:53:49 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDx0-0001jh-Cb
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:53:43 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181204165319euoutp0274053399b5446628b0ca5b94590f4e4d~tL261KS5q2433724337euoutp02I
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 16:53:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181204165319euoutp0274053399b5446628b0ca5b94590f4e4d~tL261KS5q2433724337euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543942399;
 bh=3Gy19u7ujopRImB6K3a2IRhlzcOT0dGfmzDpFutEgm4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XAv3vxt+HxmRXNMH8xQdOIZf91pMaUtWziF344od3pFX/3LXy982B/qOD3fGpo5mk
 vbyQF3u8fhEOIJt1kHL60Uok+9yO3wa6zwth649Hh/YuODLep6HR7qLgiZ8c9A/zYG
 +afcsrQA3qCz4MaPepGpfJvlOYuvju9xZ46QkOQU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181204165319eucas1p2cd8e65bef16e380d1c51378919ac7df8~tL26JR-cq2508625086eucas1p2t;
 Tue,  4 Dec 2018 16:53:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id C3.57.04441.EF0B60C5; Tue,  4
 Dec 2018 16:53:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee~tL25Vdj_r0098000980eucas1p2F;
 Tue,  4 Dec 2018 16:53:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181204165317eusmtrp2996c9e7dd98ce6949a7442b6c72f1cc4~tL25G1cId2531625316eusmtrp2J;
 Tue,  4 Dec 2018 16:53:17 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-71-5c06b0fe877d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.6D.04128.DF0B60C5; Tue,  4
 Dec 2018 16:53:17 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181204165317eusmtip173ce584de5ba82c2ffb9425636cde8a8~tL24l5DUt2005320053eusmtip19;
 Tue,  4 Dec 2018 16:53:17 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Date: Tue,  4 Dec 2018 17:52:48 +0100
Message-Id: <20181204165248.17572-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7r/NrDFGKw5p2lx/ctzVov5R86x
 WvTt+89o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZLL1+kcmide8RdgcujzXz1jB6bFrV
 yeaxeUm9x8F3e5g8+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK2PGo11sBc+iKzbsO8nWwNgZ
 0MXIySEhYCIxd/9Npi5GLg4hgRWMEiu7vrNBOF8YJR73P2WBcD4zSmzoWc8K0/JpwXFWiMRy
 RokLzzpZ4FqOzH7JBlLFJmAu8Wj7GSYQW0TATaJv8mywOLPAbCaJC4eFQGxhAUeJVz92gsVZ
 BFQl/ix+AbaBV8BFYuqxU1Db5CUadm1mB7E5BVwlNk34xwhRIyhxcuYTFoiZ8hLNW2czgxwh
 IbCOXeJrfz8jRLOLxL6en8wQtrDEq+Nb2CFsGYn/O+czQdjlEru3PmOHaG5hlJg7eRFUwlri
 8PGLQFdwAG3QlFi/Sx8i7Chx6PgFJpCwhACfxI23ghA38ElM2jadGSLMK9HRJgRRrSsx7/8Z
 qFekJbr+r4OyPSQ+zehkncCoOAvJN7OQfDMLYe8CRuZVjOKppcW56anFhnmp5XrFibnFpXnp
 esn5uZsYgSnp9L/jn3Ywfr2UdIhRgINRiYdXYgpbjBBrYllxZe4hRgkOZiUR3jtqQCHelMTK
 qtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MDr9nyu5q2TFrd5pz
 is5bBr5jN1m0WljO+BuF9z1a9M3p9QHHM1xS60wVbk900agvXhnIIrHv/bynAT9vaxmsjZYS
 e5HhuZNFbO1/jv/1yZrKHw/FlNbtbRDyUn/pPDNrs6Tn1oojgbN1IsRXcLOm9tSfOd4h2H4s
 aSmzagsrg2ebmuStdXxKLMUZiYZazEXFiQAJWMsYRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7p/N7DFGBw5amJx/ctzVov5R86x
 WvTt+89o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZLL1+kcmide8RdgcujzXz1jB6bFrV
 yeaxeUm9x8F3e5g8+rasYvT4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
 1srIVEnfziYlNSezLLVI3y5BL2PGo11sBc+iKzbsO8nWwNgZ0MXIySEhYCLxacFx1i5GLg4h
 gaWMEh0NtxkhEtISjadXM0HYwhJ/rnWxQRR9YpTY/O80WBGbgLnEo+1nwIpEBDwkZkxcDDaJ
 WWAxk8SlN3eYQRLCAo4Sr37sZAOxWQRUJf4sfsEKYvMKuEhMPXaKFWKDvETDrs3sIDangKvE
 pgn/wBYIAdXMmdbLDFEvKHFy5hMWEJsZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yk
 V5yYW1yal66XnJ+7iREYPduO/dyyg7HrXfAhRgEORiUeXokpbDFCrIllxZW5hxglOJiVRHjv
 qAGFeFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR8Y2Xkl8YamhuYWlobmxubGZhZK4rznDSqj
 hATSE0tSs1NTC1KLYPqYODilGhhbtxze8G5j9ESJ43qXLp59eOCpgpTXxLuX1zNe2PTt7OET
 UjM8X371TNqocvrY161sE3awfr6+49GvtL2pd+sqgj7emFmTt0taXa+pn+Ga4COzBuNXs5rf
 906y2CZ2p0BbZ16xam5j3aX5SnYH/h+ebMRptDb6ScTH/TffFUhkK671iN4+L/lWjBJLcUai
 oRZzUXEiAGPxdsW0AgAA
X-CMS-MailID: 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee
X-Msg-Generator: CA
X-RootMTR: 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_085335_495602_D45B074E 
X-CRM114-Status: GOOD (  14.65  )
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
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imem clocks for exynos5433. This will enable to use crypto Security
SubSystem (in short SSS) and SlimSSS IP blocks.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c   | 193 +++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5433.h |  55 +++++++
 2 files changed, 248 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 24c3360db65b..7f557d6f41f0 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -5467,6 +5467,196 @@ static const struct samsung_cmu_info cam1_cmu_info __initconst = {
 	.clk_name		= "aclk_cam1_400",
 };
 
+/*
+ * Register offset definitions for CMU_IMEM
+ */
+#define ENABLE_ACLK_IMEM			0x0800
+#define ENABLE_ACLK_IMEM_INT_MEM		0x0804
+#define ENABLE_ACLK_IMEM_SSS			0x0808
+#define ENABLE_ACLK_IMEM_SLIMSSS		0x080c
+#define ENABLE_ACLK_IMEM_RTIC			0x0810
+#define ENABLE_ACLK_IMEM_SMMU_SSS		0x0814
+#define ENABLE_ACLK_IMEM_SMMU_SLIMSSS		0x0818
+#define ENABLE_ACLK_IMEM_SMMU_RTIC		0x081c
+#define ENABLE_ACLK_IMEM_ARBG_TX		0x0820
+#define ENABLE_ACLK_IMEM_SMMU_ARBG_TX		0x0824
+#define ENABLE_PCLK_IMEM			0x0900
+#define ENABLE_PCLK_IMEM_SSS			0x0904
+#define ENABLE_PCLK_IMEM_SLIMSSS		0x0908
+#define ENABLE_PCLK_IMEM_RTIC			0x090c
+#define ENABLE_PCLK_IMEM_SMMU_SSS		0x0910
+#define ENABLE_PCLK_IMEM_SMMU_SLIMSSS		0x0914
+#define ENABLE_PCLK_IMEM_SMMU_RTIC		0x0918
+#define ENABLE_PCLK_IMEM_SMMU_ARGB_TX		0x091c
+
+static const unsigned long imem_clk_regs[] __initconst = {
+	ENABLE_ACLK_IMEM,
+	ENABLE_ACLK_IMEM_INT_MEM,
+	ENABLE_ACLK_IMEM_SSS,
+	ENABLE_ACLK_IMEM_SLIMSSS,
+	ENABLE_ACLK_IMEM_RTIC,
+	ENABLE_ACLK_IMEM_SMMU_SSS,
+	ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
+	ENABLE_ACLK_IMEM_SMMU_RTIC,
+	ENABLE_ACLK_IMEM_ARBG_TX,
+	ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
+	ENABLE_PCLK_IMEM,
+	ENABLE_PCLK_IMEM_SSS,
+	ENABLE_PCLK_IMEM_SLIMSSS,
+	ENABLE_PCLK_IMEM_RTIC,
+	ENABLE_PCLK_IMEM_SMMU_SSS,
+	ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
+	ENABLE_PCLK_IMEM_SMMU_RTIC,
+	ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
+};
+
+static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
+	/* ENABLE_ACLK_IMEM */
+	GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 24, 0, 0),
+	GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_SROMC, "aclk_sromc", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 22, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_BTS_ARBG_TX, "aclk_bts_arbg_tx", "aclk_imem_266",
+			ENABLE_ACLK_IMEM, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_ASYNCAXI_IMEMX, "aclk_asyncaxi_imemx", "aclk_imem_266",
+			ENABLE_ACLK_IMEM, 20, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AXIUS_IMEMX, "aclk_axius_imemx", "aclk_imem_266",
+			ENABLE_ACLK_IMEM, 19, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_XIU_IMEMX, "aclk_xiu_imemx", "aclk_imem_266",
+			ENABLE_ACLK_IMEM, 18, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_ASYNCAXI_SSSX, "aclk_asyncaxi_sssx", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_BTS_SLIMSSS, "aclk_bts_slimsss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM, 15, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_BTS_SSS_DRAM, "aclk_bts_sss_dram", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM, 14, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_BTS_SSS_CCI, "aclk_bts_sss_cci", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_ALB_IMEM, "aclk_alb_imem", "aclk_imem_266",
+			ENABLE_ACLK_IMEM, 12, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AXIDS_PIMEMX_IMEM1P, "aclk_axids_pimemx_imem1p", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 11, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AXIDS_PIMEMX_IMEM0P, "aclk_axids_pimemx_imem0p", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 10, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AXIDS_PIMEMX_GIC, "aclk_axids_pimemx_gic", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 9, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_ASYNCAHBM_SSS_ATLAS, "aclk_asyncahbm_sss_atlas", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_ASYNCAXIS_MIF_PIMEMX, "aclk_asyncaxis_mif_pimemx", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 6, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AXI2APB_IMEM1P, "aclk_axi2apb_imem1p", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 5, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_AXI2APB_IMEM0P, "aclk_axi2apb_imem0p", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_XIU_SSSX, "aclk_xiu_sssx", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM, 3, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_XIU_PIMEMX, "aclk_xiu_pimemx", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 2, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_IMEMND_266, "aclk_imemnd_266", "aclk_imem_266",
+			ENABLE_ACLK_IMEM, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_GIC, "aclk_gic", "aclk_imem_200",
+			ENABLE_ACLK_IMEM, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_IMEM_INT_MEM */
+	GATE(CLK_ACLK_INT_MEM, "aclk_int_mem", "aclk_imem_200",
+			ENABLE_ACLK_IMEM_INT_MEM, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_IMEM_SSS */
+	GATE(CLK_ACLK_SSS, "aclk_sss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_SSS, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_IMEM_SLIMSSS */
+	GATE(CLK_ACLK_SLIMSSS, "aclk_slimsss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_IMEM_RTIC */
+	GATE(CLK_ACLK_RTIC, "aclk_rtic", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_SMMU_SSS */
+	GATE(CLK_ACLK_SMMU_SSS_DRAM, "aclk_smmu_sss_dram", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_SSS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_SMMU_SSS_CCI, "aclk_smmu_sss_cci", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_SSS, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_SMMU_SLIMSSS */
+	GATE(CLK_ACLK_SMMU_SLIMSSS, "aclk_smmu_slimsss", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_ACLK_SMMU_RTIC */
+	GATE(CLK_ACLK_SMMU_RTIC, "aclk_smmu_rtic", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_ACLK_IMEM_ARBG_TX */
+	GATE(CLK_ACLK_ARBG_TX, "aclk_arbg_tx", "aclk_imem_266",
+		ENABLE_ACLK_IMEM_ARBG_TX, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_ACLK_IMEM_SMMU_ARBG_TX */
+	GATE(CLK_ACLK_SMMU_ARBG_TX, "aclk_smmu_arbg_tx", "aclk_imem_266",
+		ENABLE_ACLK_IMEM_SMMU_ARBG_TX, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_PCLK_IMEM */
+	GATE(CLK_PCLK_GPIO_IMEM, "pclk_gpio_imem", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 17, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_ASYNCAXI_IMEMX, "pclk_asyncaxi_imemx", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 16, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_BTS_ARBG_TX, "pclk_bts_arbg_tx", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 15, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_ASYNCAPB_ARBG_TX, "pclk_asyncapb_arbg_tx", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 14, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_BTS_SLIMSSS, "pclk_bts_slimsss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 8, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_BTS_SSS_DRAM, "pclk_bts_sss_dram", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 7, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_BTS_SSS_CCI, "pclk_bts_sss_cci", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 6, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_ALB_IMEM, "pclk_alb_imem", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 5, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PMU_IMEM, "pclk_pmu_imem", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 4, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_SYSREG_IMEM, "pclk_sysreg_imem", "aclk_imem_200",
+			ENABLE_PCLK_IMEM, 3, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_PCLK_IMEM_SSS */
+	GATE(CLK_PCLK_SSS, "pclk_sss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM_SSS, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_PCLK_IMEM_SLIMSSS */
+	GATE(CLK_PCLK_SLIMSSS, "pclk_slimsss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_PCLK_IMEM_RTIC */
+	GATE(CLK_PCLK_RTIC, "pclk_rtic", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_PCLK_IMEM_SMMU_SSS */
+	GATE(CLK_PCLK_SMMU_SSS_DRAM, "pclk_smmu_sss_dram", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_SSS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_SMMU_SSS_CCI, "pclk_smmu_sss_cci", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_SSS, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_PCLK_IMEM_SMMU_SLIMSSS */
+	GATE(CLK_PCLK_SMMU_SLIMSSS, "pclk_smmu_slimsss", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_PCLK_IMEM_SMMU_RTIC */
+	GATE(CLK_PCLK_SMMU_RTIC, "pclk_sss", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+	
+	/* ENABLE_PCLK_IMEM_SMMU_ARGB_TX */
+	GATE(CLK_PCLK_SMMU_ARBG_TX, "pclk_smmu_arbg_tx", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_ARGB_TX, 0, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info imem_cmu_info __initconst = {
+	.gate_clks		= imem_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
+	.nr_clk_ids		= IMEM_NR_CLK,
+	.clk_regs		= imem_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
+};
 
 struct exynos5433_cmu_data {
 	struct samsung_clk_reg_dump *clk_save;
@@ -5654,6 +5844,9 @@ static const struct of_device_id exynos5433_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-cmu-mscl",
 		.data = &mscl_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-imem",
+		.data = &imem_cmu_info,
 	}, {
 	},
 };
diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
index 87bb2b017143..cc6153a0b5f7 100644
--- a/include/dt-bindings/clock/exynos5433.h
+++ b/include/dt-bindings/clock/exynos5433.h
@@ -1406,4 +1406,59 @@
 
 #define CAM1_NR_CLK					113
 
+/* CMU_IMEM */
+#define CLK_ACLK_SSS			1
+#define CLK_ACLK_SLIMSSS		2
+#define CLK_ACLK_RTIC			3
+#define CLK_ACLK_XIU_SSSX		4
+#define CLK_ACLK_ASYNCAHBM_SSS_ATLAS	5
+#define CLK_ACLK_ASYNCAXI_SSSX		6
+#define CLK_ACLK_BTS_SSS_CCI		7
+#define CLK_ACLK_BTS_SSS_DRAM		8
+#define CLK_ACLK_BTS_SLIMSSS		9
+#define CLK_ACLK_SMMU_SSS_CCI		10
+#define CLK_ACLK_SMMU_SSS_DRAM		11
+#define CLK_ACLK_SMMU_SLIMSSS		12
+#define CLK_ACLK_SMMU_RTIC		13
+#define CLK_ACLK_IMEMND_266		14
+#define CLK_ACLK_ALB_IMEM		15
+#define CLK_ACLK_XIU_IMEMX		16
+#define CLK_ACLK_AXIUS_IMEMX		17
+#define CLK_ACLK_ASYNCAXI_IMEMX		18
+#define CLK_ACLK_ARBG_TX		19
+#define CLK_ACLK_BTS_ARBG_TX		20
+#define CLK_ACLK_SMMU_ARBG_TX		21
+#define CLK_ACLK_GIC			22
+#define CLK_ACLK_INT_MEM		23
+#define CLK_ACLK_XIU_PIMEMX		24
+#define CLK_ACLK_AXI2APB_IMEM0P		25
+#define CLK_ACLK_AXI2APB_IMEM1P		26
+#define CLK_ACLK_ASYNCAXIS_MIF_PIMEMX	27
+#define CLK_ACLK_AXIDS_PIMEMX_GIC	28
+#define CLK_ACLK_AXIDS_PIMEMX_IMEM0P	29
+#define CLK_ACLK_AXIDS_PIMEMX_IMEM1P	30
+#define CLK_ACLK_SROMC			31
+#define CLK_ACLK_AXIDS_SROMC		32
+#define CLK_ACLK_AXI2AHB_IMEMH		33
+#define CLK_PCLK_SSS			34
+#define CLK_PCLK_SLIMSSS		35
+#define CLK_PCLK_RTIC			36
+#define CLK_PCLK_SYSREG_IMEM		37
+#define CLK_PCLK_PMU_IMEM		38
+#define CLK_PCLK_ALB_IMEM		39
+#define CLK_PCLK_BTS_SSS_CCI		40
+#define CLK_PCLK_BTS_SSS_DRAM		41
+#define CLK_PCLK_BTS_SLIMSSS		42
+#define CLK_PCLK_SMMU_SSS_CCI		43
+#define CLK_PCLK_SMMU_SSS_DRAM		44
+#define CLK_PCLK_SMMU_SLIMSSS		45
+#define CLK_PCLK_SMMU_RTIC		46
+#define CLK_PCLK_ASYNCAPB_ARBG_TX	47
+#define CLK_PCLK_BTS_ARBG_TX		48
+#define CLK_PCLK_SMMU_ARBG_TX		49
+#define CLK_PCLK_ASYNCAXI_IMEMX		50
+#define CLK_PCLK_GPIO_IMEM		51
+
+#define IMEM_NR_CLK			52
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS5433_H */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
