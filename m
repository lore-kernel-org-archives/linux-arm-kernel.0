Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789DC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEFF20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rD6vdrXL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IElhvhbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEFF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TNQTx2MjLObYjDXmChRdp+m3BCOu8dQIYmuuOmjWv/Q=; b=rD6vdrXLAHeL52
	sZQqJuliSWPitCfKsvNo5TrHCEvIVPFsotUI2S1VzgrCc3bTCV5KabCX+a4d5jylg4x5hOBV0k0Eh
	WHNe5XXyQ2ZmYPYBHky0R0iuxynovcZo5oVItVotF+mPH4Nkyfxz9J6H7/MDps4T09u/jwPYZWymV
	D5dLtJuvXUmntB3HVtczvG3svA1qks4VExq2axrf3I83z45Q3FIhLsOBRw00cczxTfSqkoHrhltkX
	HwQTiMTKZatY2DC9jBTJWKX7hAKgp3hQZrlyiupqgR4jcePimFtx2FaSsPoFTFe/031iGvKgh9obX
	wZsUu8Ps8XO4JIs8U3WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSObq-0006oK-EI; Thu, 29 Nov 2018 15:52:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSObi-0006lm-W5
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:52:09 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181129155148euoutp0247cd77751e679bb33b06c606464c8a05~royx4WFxJ1133211332euoutp02E
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 15:51:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181129155148euoutp0247cd77751e679bb33b06c606464c8a05~royx4WFxJ1133211332euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543506708;
 bh=Sln63ZC64ibwk6f9u2hGbOO0ev7FYy3P5oc6ty/Ap2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IElhvhbHcDqvlBaLY4KlD3a8okcYjIi00yBjB6F5wqU2LSePJELAxkuVqRLhzsYlH
 00vkBgY2/tPyLEYao/JZdkE5z/6ZNGS1mQ5QidDHdMUF3uRjOfx7B0UcLRk+5hZFUw
 vqckMapPKZ3lVEdhjuKCEmIW5ZYS1TRHAoVaU5JI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181129155148eucas1p1d305536b50ac3c0a3774870ab1a969d4~royxTdx6O2701627016eucas1p1y;
 Thu, 29 Nov 2018 15:51:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id AE.4F.04806.31B000C5; Thu, 29
 Nov 2018 15:51:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181129155147eucas1p14b902fc9c4e9abda03dcf506486d4152~roywWEGRz1648416484eucas1p1X;
 Thu, 29 Nov 2018 15:51:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181129155146eusmtrp1c4f59c764761e8c6f7221155e10d64d2~roywHZk3Z3243432434eusmtrp1b;
 Thu, 29 Nov 2018 15:51:46 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-b3-5c000b137fe8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.E2.04284.21B000C5; Thu, 29
 Nov 2018 15:51:46 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181129155146eusmtip23d4eea3d5619c880685b2d351f7ca7e4~royvo7c5f2889528895eusmtip2U;
 Thu, 29 Nov 2018 15:51:46 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v2 5/5] clk: samsung: exynos5433: add imem clock
Date: Thu, 29 Nov 2018 16:51:34 +0100
Message-Id: <20181129155134.19141-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129155134.19141-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7rC3AwxBivW6lvMP3KO1aJv339G
 i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYun1i0wWrXuPsDtweqyZt4bRY9OqTjaPzUvq
 PQ6+28Pk8XmTXABrFJdNSmpOZllqkb5dAlfGka272At+xlZ8Or+HpYFxYlAXIweHhICJxK+v
 WV2MXBxCAisYJQ6cfc0C4XxhlDi5opURwvnMKPF201r2LkZOsI4rj3axQiSWM0rsuHQeoaXp
 9kUmkCo2AXOJR9vPgNkiAsoSk+9NZwYpYhaYwSSx5thXNpCEsICDxJ2N58CKWARUJRo75zKC
 2LwCLhJXfq1mg1gnL9GwazPYak4BV4lpK/czQ9QISpyc+YQFxGYGqmneOhtsgYTAInaJOY0d
 LBDNLhKztu2AsoUlXh3fAvWDjMTpyT1Q8XKJ3VufsUM0tzBKzJ28iAkiYS1x+PhFVlAwMQto
 SqzfpQ8RdpR4ve4uMyT0+CRuvBWEuIFPYtK26VBhXomONiGIal2Jef/PsELY0hJd/9dB2R4S
 K6asYZ3AqDgLyTezkHwzC2HvAkbmVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHp5/S/
 4193MO77k3SIUYCDUYmH1+HX/2gh1sSy4srcQ4wSHMxKIryHORhihHhTEiurUovy44tKc1KL
 DzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTBW/fCN/G20N2ye2vWrqxw83t72ynyq
 891KbrtQHm+qz4bl62rbgh6UnxeYsWjGeZ/7C0+lb328z1w04cSUitv+US7Jf3K+zRHadEq+
 fbpixZdJ3z45el1W2K/h0LVuxfSzu6/5ZwSJTt3SWHNkxexl0uq/RSc1P1gT/oBr31bvlI8H
 C7ijpZiZlFiKMxINtZiLihMBaMSZPjsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7pC3AwxBjdP61jMP3KO1aJv339G
 i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYun1i0wWrXuPsDtweqyZt4bRY9OqTjaPzUvq
 PQ6+28Pk8XmTXABrlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
 Zllqkb5dgl7Gka272At+xlZ8Or+HpYFxYlAXIyeHhICJxJVHu1i7GLk4hASWMkqs+3SPHSIh
 LdF4ejUThC0s8edaFxuILSTwiVGie2MAiM0mYC7xaPsZsBoRAWWJyfemM4MMYhZYwCSx5coz
 RpCEsICDxJ2N58CKWARUJRo754LFeQVcJK78Ws0GsUBeomHXZrDFnAKuEtNW7meGWOYi8ejQ
 cqh6QYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypGkdTS4tz03GJDveLE3OLSvHS95Pzc
 TYzAONl27OfmHYyXNgYfYhTgYFTi4XX49T9aiDWxrLgy9xCjBAezkgjvYQ6GGCHelMTKqtSi
 /Pii0pzU4kOMpkBPTGSWEk3OB8ZwXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC
 1CKYPiYOTqkGxgTbor3NCjEZ9k16qsr1YjJFSaFv8lPrOpr1f0/eoHh01k6Vs1cv7sv+d35t
 ovGajeYLXkhUHNJ6Y5ndfaVp4m/m5xoHdP5sdfdep3UzOuXG3OwL/xo+zTleHL7qZGz2foer
 k7Zt/yBs9+zz+wk6swSWHNx+/+6b5vmm108LXs4wMvD7K55o/V6JpTgj0VCLuag4EQDtDSa3
 qQIAAA==
X-CMS-MailID: 20181129155147eucas1p14b902fc9c4e9abda03dcf506486d4152
X-Msg-Generator: CA
X-RootMTR: 20181129155147eucas1p14b902fc9c4e9abda03dcf506486d4152
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181129155147eucas1p14b902fc9c4e9abda03dcf506486d4152
References: <20181129155134.19141-1-k.konieczny@partner.samsung.com>
 <CGME20181129155147eucas1p14b902fc9c4e9abda03dcf506486d4152@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_075203_300943_13F475B6 
X-CRM114-Status: GOOD (  14.22  )
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
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imem clock for exynos5433. This will enable to use crypto Security
SubSystem (in short SSS) and SlimSSS IP blocks.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c   | 189 +++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5433.h |  55 +++++++
 2 files changed, 244 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 24c3360db65b..ab03126f350b 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -2345,6 +2345,192 @@ static const struct samsung_cmu_info fsys_cmu_info __initconst = {
 	.clk_name		= "aclk_fsys_200",
 };
 
+/*
+ * Register offset definitions for CMU_IMEM
+ *
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
+	/* ENABLE_ACLK_IMEM_SSS */
+	GATE(CLK_ACLK_SSS, "aclk_sss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_SSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_ACLK_IMEM_SLIMSSS */
+	GATE(CLK_ACLK_SLIMSSS, "aclk_slimsss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_ACLK_IMEM_RTIC */
+	GATE(CLK_ACLK_RTIC, "aclk_rtic", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_ACLK_SMMU_SSS */
+	GATE(CLK_ACLK_SMMU_SSS_DRAM, "aclk_smmu_sss_dram", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_SSS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_SMMU_SSS_CCI, "aclk_smmu_sss_cci", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_SSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_ACLK_SMMU_SLIMSSS */
+	GATE(CLK_ACLK_SMMU_SLIMSSS, "aclk_smmu_slimsss", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_ACLK_SMMU_RTIC */
+	GATE(CLK_ACLK_SMMU_RTIC, "aclk_smmu_rtic", "aclk_imem_sssx_266",
+		ENABLE_ACLK_IMEM_SMMU_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_ACLK_IMEM_ARBG_TX */
+	GATE(CLK_ACLK_ARBG_TX, "aclk_arbg_tx", "aclk_imem_266",
+		ENABLE_ACLK_IMEM_ARBG_TX, 0, CLK_IGNORE_UNUSED, 0),
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
+
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
+	/* ENABLE_PCLK_IMEM_SSS */
+	GATE(CLK_PCLK_SSS, "pclk_sss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM_SSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_PCLK_IMEM_SLIMSSS */
+	GATE(CLK_PCLK_SLIMSSS, "pclk_slimsss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_PCLK_IMEM_RTIC */
+	GATE(CLK_PCLK_RTIC, "pclk_rtic", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_RTIC, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_PCLK_IMEM_SMMU_SSS */
+	GATE(CLK_PCLK_SMMU_SSS_DRAM, "pclk_smmu_sss_dram", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_SSS, 1, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_SMMU_SSS_CCI, "pclk_smmu_sss_cci", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_SSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_PCLK_IMEM_SMMU_SLIMSSS */
+	GATE(CLK_PCLK_SMMU_SLIMSSS, "pclk_smmu_slimsss", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+	/* ENABLE_PCLK_IMEM_SMMU_RTIC */
+	GATE(CLK_PCLK_SMMU_RTIC, "pclk_sss", "aclk_imem_200",
+		ENABLE_PCLK_IMEM_SMMU_RTIC, 0, CLK_IGNORE_UNUSED, 0),
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
+
+static void __init exynos5433_cmu_imem_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &imem_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos5433_cmu_imem, "samsung,exynos5433-cmu-imem",
+		exynos5433_cmu_imem_init);
+
 /*
  * Register offset definitions for CMU_G2D
  */
@@ -5648,6 +5834,9 @@ static const struct of_device_id exynos5433_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-cmu-hevc",
 		.data = &hevc_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-imem",
+		.data = &imem_cmu_info,
 	}, {
 		.compatible = "samsung,exynos5433-cmu-isp",
 		.data = &isp_cmu_info,
diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
index 87bb2b017143..312d8810b56d 100644
--- a/include/dt-bindings/clock/exynos5433.h
+++ b/include/dt-bindings/clock/exynos5433.h
@@ -623,6 +623,61 @@
 
 #define FSYS_NR_CLK			116
 
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
 /* CMU_G2D */
 #define CLK_MUX_ACLK_G2D_266_USER	1
 #define CLK_MUX_ACLK_G2D_400_USER	2
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
