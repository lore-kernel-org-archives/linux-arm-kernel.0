Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B192320834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h1Td2gaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B192320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FgWQ31fWh18ewqSH7jYNN7nMINyvXOfk5nau98d2+/w=; b=h1Td2gaA0Kzjha
	nDafbywydyIo4pPTHtDfp2pyVTTvjZsmq+Nklie1XtLtIm1ADbqhMUkD3tKggnJDV3CAb0pjhVpu+
	MHA8qfDhw7URe4p0AcUGjgmFDo9DVjxy5k4DfBNlUbHd0ZSKjo3O1C6SHWgVDHkHCOao3f4+pB6Mx
	MFYM0LHN1wXmM5hIWvVOSICHuNJBGdeupaZgctYTBYYrYo3vO/6f1vk+E79LgnFo5u+cbkbP/2s2G
	VcooR5ncOVWzF+JTgbTRDKWmZ8pWmrpRLD7m9pyIoxPAS5/36l6VvEqmQGoRt0edNFXQkQ+erYEkJ
	keI3+znTS+0q4d2Af1Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrU3-0008FS-Q6; Mon, 03 Dec 2018 16:54:11 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrTz-0008El-IZ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:54:09 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3FB9413F8AC;
 Mon,  3 Dec 2018 17:53:38 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
Message-ID: <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
Date: Mon, 3 Dec 2018 17:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_085407_903038_65F64B38 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03/12/2018 16:18, Marc Gonzalez wrote:

> I'm trying to enable UFS on apq8098. Just wanted to share my progress
> so far, in case someone spots any glaring mistakes.
> 
> rpm_smd_clk_probe() runs successfully, and returns 0.
> 
> qcom_qmp_phy_probe() fails:
> 
> [    0.913707] qcom-qmp-phy 1da7000.phy: Failed to get clk 'ref': -2
> [    0.913761] qcom-qmp-phy: probe of 1da7000.phy failed with error -2
> 
> ufs_qcom_probe() also fails (which may be caused by PHY failure)
> 
> [    2.368486] ufshcd-qcom 1da4000.ufshc: ufshcd_get_vreg: vdd-hba get failed, err=-517
> [    2.370673] ufshcd-qcom 1da4000.ufshc: Initialization failed
> [    2.412908] ufshcd-qcom 1da4000.ufshc: ufshcd_pltfrm_init() failed -517

Having solved these trivial issues, I hit other issues later on.
(Full diff provided below, including code from Bjorn and Jeffrey)

Relevant logs:

[    0.970565] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.15
[    0.970676] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.16
[    0.971349] qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy
[    2.293324] ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
[    2.355902] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.34
[    2.359197] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.40
[    2.365857] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.5
[    2.400665] scsi host0: ufshcd
[    2.435181] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
[    3.968211] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    5.472133] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    6.976114] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    6.976387] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
[    6.984999] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init setting fDeviceInit flag failed with error -11

I will investigate :-)

Regards.


diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index b4276da1fb0d..cc35086422b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -241,3 +241,26 @@
 		};
 	};
 };
+
+&ufshc {
+	status = "ok";
+/***	vdd-hba-supply = <&gcc UFS_GDSC>;	-EPROBE_DEFER ***/
+	vdd-hba-fixed-regulator;
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l26a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vcc-max-microamp = <750000>;
+	vccq-max-microamp = <560000>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufsphy {
+	status = "ok";
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
+	vdda-phy-max-microamp = <51400>;
+	vdda-pll-max-microamp = <14600>;
+	vddp-ref-clk-max-microamp = <100>;
+	vddp-ref-clk-always-on;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index d291b4713c33..b5b2b05bc782 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -264,6 +264,11 @@
 		rpm_requests: rpm-requests {
 			compatible = "qcom,rpm-msm8998";
 			qcom,glink-channels = "rpm_requests";
+
+			rpmcc: qcom,rpmcc {
+				compatible = "qcom,rpmcc-msm8998";
+				#clock-cells = <1>;
+			};
 		};
 	};
 
@@ -686,5 +691,75 @@
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ufshc: ufshc@1da4000 {
+			compatible = "qcom,msm8998-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x1da4000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufsphy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			power-domains = <&gcc UFS_GDSC>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk";
+			clocks =
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE1_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_ICE_CORE_CLK>,
+				<&rpmcc 0>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			resets = <&gcc GCC_UFS_BCR>;
+			reset-names = "rst";
+
+			status = "disabled";
+		};
+
+		ufsphy: phy@1da7000 {
+			compatible = "qcom,sdm845-qmp-ufs-phy";
+			reg = <0x1da7000 0x18c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-names = "ref", "ref_aux";
+			clocks =
+				<&gcc GCC_UFS_CLKREF_CLK>,
+				<&gcc GCC_UFS_PHY_AUX_CLK>;
+
+			status = "disabled";
+
+			ufsphy_lanes: lanes@1da7400 {
+				reg = <0x1da7400 0x108>,
+				      <0x1da7600 0x1e0>,
+				      <0x1da7c00 0x1dc>,
+				      <0x1da7800 0x108>,
+				      <0x1da7a00 0x1e0>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 850c02a52248..12a0a2d6ec7b 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -611,10 +611,25 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
 	.num_clks = ARRAY_SIZE(msm8996_clks),
 };
 
+/* msm8998 */
+#define LN_BB_CLK1_ID 0x1
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, ln_bb_clk1, ln_bb_a_clk1, LN_BB_CLK1_ID);
+
+static struct clk_smd_rpm *msm8998_clks[] = {
+	[0] = &msm8998_ln_bb_clk1,
+	[1] = &msm8998_ln_bb_a_clk1,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
+	.clks = msm8998_clks,
+	.num_clks = ARRAY_SIZE(msm8998_clks),
+};
+
 static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
 	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
 	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
+	{ .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 9f0ae403d5f5..4fc1502cab5c 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_hmss_dvm_bus_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2015,6 +2016,7 @@ static struct clk_branch gcc_lpass_at_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_lpass_at_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2401,7 +2403,7 @@ static struct clk_branch gcc_ufs_phy_aux_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 	.halt_reg = 0x75014,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75014,
 		.enable_mask = BIT(0),
@@ -2414,7 +2416,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 	.halt_reg = 0x7605c,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x7605c,
 		.enable_mask = BIT(0),
@@ -2427,7 +2429,7 @@ static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 
 static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
 	.halt_reg = 0x75010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75010,
 		.enable_mask = BIT(0),
@@ -2541,6 +2543,76 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
 	},
 };
 
+static struct clk_branch gcc_hdmi_clkref_clk = {
+	.halt_reg = 0x88000,
+	.clkr = {
+		.enable_reg = 0x88000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_hdmi_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_clkref_clk = {
+	.halt_reg = 0x88004,
+	.clkr = {
+		.enable_reg = 0x88004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_clkref_clk = {
+	.halt_reg = 0x88008,
+	.clkr = {
+		.enable_reg = 0x88008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_clkref_clk = {
+	.halt_reg = 0x8800c,
+	.clkr = {
+		.enable_reg = 0x8800c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_rx1_usb2_clkref_clk = {
+	.halt_reg = 0x88014,
+	.clkr = {
+		.enable_reg = 0x88014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_rx1_usb2_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
 	.gds_hw_ctrl = 0x0,
@@ -2733,6 +2805,11 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
 	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
 	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
 	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
+	[GCC_HDMI_CLKREF_CLK] = &gcc_hdmi_clkref_clk.clkr,
+	[GCC_UFS_CLKREF_CLK] = &gcc_ufs_clkref_clk.clkr,
+	[GCC_USB3_CLKREF_CLK] = &gcc_usb3_clkref_clk.clkr,
+	[GCC_PCIE_CLKREF_CLK] = &gcc_pcie_clkref_clk.clkr,
+	[GCC_RX1_USB2_CLKREF_CLK] = &gcc_rx1_usb2_clkref_clk.clkr,
 };
 
 static struct gdsc *gcc_msm8998_gdscs[] = {
@@ -2742,25 +2819,25 @@ static struct gdsc *gcc_msm8998_gdscs[] = {
 };
 
 static const struct qcom_reset_map gcc_msm8998_resets[] = {
-	[GCC_BLSP1_QUP1_BCR] = { 0x102400 },
-	[GCC_BLSP1_QUP2_BCR] = { 0x110592 },
-	[GCC_BLSP1_QUP3_BCR] = { 0x118784 },
-	[GCC_BLSP1_QUP4_BCR] = { 0x126976 },
-	[GCC_BLSP1_QUP5_BCR] = { 0x135168 },
-	[GCC_BLSP1_QUP6_BCR] = { 0x143360 },
-	[GCC_BLSP2_QUP1_BCR] = { 0x155648 },
-	[GCC_BLSP2_QUP2_BCR] = { 0x163840 },
-	[GCC_BLSP2_QUP3_BCR] = { 0x172032 },
-	[GCC_BLSP2_QUP4_BCR] = { 0x180224 },
-	[GCC_BLSP2_QUP5_BCR] = { 0x188416 },
-	[GCC_BLSP2_QUP6_BCR] = { 0x196608 },
-	[GCC_PCIE_0_BCR] = { 0x438272 },
-	[GCC_PDM_BCR] = { 0x208896 },
-	[GCC_SDCC2_BCR] = { 0x81920 },
-	[GCC_SDCC4_BCR] = { 0x90112 },
-	[GCC_TSIF_BCR] = { 0x221184 },
-	[GCC_UFS_BCR] = { 0x479232 },
-	[GCC_USB_30_BCR] = { 0x61440 },
+	[GCC_BLSP1_QUP1_BCR] = { 0x19000 },
+	[GCC_BLSP1_QUP2_BCR] = { 0x1b000 },
+	[GCC_BLSP1_QUP3_BCR] = { 0x1d000 },
+	[GCC_BLSP1_QUP4_BCR] = { 0x1f000 },
+	[GCC_BLSP1_QUP5_BCR] = { 0x21000 },
+	[GCC_BLSP1_QUP6_BCR] = { 0x23000 },
+	[GCC_BLSP2_QUP1_BCR] = { 0x26000 },
+	[GCC_BLSP2_QUP2_BCR] = { 0x28000 },
+	[GCC_BLSP2_QUP3_BCR] = { 0x2a000 },
+	[GCC_BLSP2_QUP4_BCR] = { 0x2c000 },
+	[GCC_BLSP2_QUP5_BCR] = { 0x2e000 },
+	[GCC_BLSP2_QUP6_BCR] = { 0x30000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_BCR] = { 0x75000 },
+	[GCC_USB_30_BCR] = { 0xf000 },
 };
 
 static const struct regmap_config gcc_msm8998_regmap_config = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index 58a242e656b1..b3448800980a 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -180,6 +180,11 @@
 #define USB30_MASTER_CLK_SRC					163
 #define USB30_MOCK_UTMI_CLK_SRC					164
 #define USB3_PHY_AUX_CLK_SRC					165
+#define GCC_USB3_CLKREF_CLK					166
+#define GCC_HDMI_CLKREF_CLK					167
+#define GCC_UFS_CLKREF_CLK					168
+#define GCC_PCIE_CLKREF_CLK					169
+#define GCC_RX1_USB2_CLKREF_CLK					170
 
 #define PCIE_0_GDSC						0
 #define UFS_GDSC						1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
