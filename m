Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB78C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:28:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04EE2064A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SIpmy69z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GYsseNZK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IGb1JSs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04EE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vtQdxF4qOj1i871iE10Huk6KXHbQY0QQAozCQIFEeYU=; b=SIpmy69z0Zevqdi8/XJxFgrH1
	6jQ4lbitN3VEXA1QzNW0BwNCEASpT+XNCKnXICBYyWYETSYIYOGkhFIlOEdOinOnJ1dusgoh/aQc3
	AscQhJhsEvfY+de+ISJJ2Zn7am2nsAEltLM7+ZunUxhE5sZdektpwfQMQQ/YPsnjklxkIh5BPAHlQ
	p+aLSNmS7QPT1x6IwjC2AFzg73SWD9FCWT8EV+E603EuPFiWWKur49A5SSCTAdlV28NZPqYldMqX5
	FHnKzN5Ynn/ctpdaq/mzhPu1xc29iQNJTgBIUxf2N5fUdfk2zDyltvUtKxwosvrUZXxb6pq2mfiAY
	y5R45u7pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTq8s-0005yx-V4; Mon, 03 Dec 2018 15:28:14 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTq8p-0005yP-Hr
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:28:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 9E7E06020A; Mon,  3 Dec 2018 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543850880;
 bh=3dkJaauSq2duYUcsbJj7FOIom+dZiHqh6kKTN0/EAnw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GYsseNZKOTKIYqHcp1z0hojY9GNrpxx7H3V3yF3vEVWQiiJu+zaoCc2s8iJBuyfIf
 TeFE52Q+C70B5K67Z7wle/L4uX1DymlC7OpgTQYPRGM2jpPiLa5LX0cVkYD7nggSCo
 bOmq26bzy8YzKy9cpmPcFWjmSZmW0dZLkdEvJ4/4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E935E6020A;
 Mon,  3 Dec 2018 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543850879;
 bh=3dkJaauSq2duYUcsbJj7FOIom+dZiHqh6kKTN0/EAnw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=IGb1JSs4A4Hv1VqtiNiPBOjcDDu7EjjPUjU6DLvd5kXWkF9add8bX/X5RxgJ33CpW
 pYing3ec4felIp2MeBmv2ZUA9CXnij9NUcTV2B5rg0Z4vJi3Zjq47J5aBOIkdqZ53c
 2vqds84M1/5ZL1J8yXfcxJdORvPTS85ox7lcdmDQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E935E6020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
Date: Mon, 3 Dec 2018 08:27:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_072811_630123_C610024B 
X-CRM114-Status: GOOD (  20.58  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/3/2018 8:18 AM, Marc Gonzalez wrote:
> Hello,
> 
> I'm trying to enable UFS on apq8098. Just wanted to share my progress
> so far, in case someone spots any glaring mistakes.

Excellent.  This was down on my todo list.  I'm glad its getting some 
attention.

> 
> (WIP patch provided at message's end.)
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
> 
> I'll investigate the PHY init.
> 
> Regards.
> 
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index b4276da1fb0d..ad7542f461af 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -241,3 +241,26 @@
>   		};
>   	};
>   };
> +
> +&ufshc {
> +	status = "ok";
> +	vdd-hba-supply = <&gcc UFS_GDSC>;
> +	vdd-hba-fixed-regulator;
> +	vcc-supply = <&vreg_l20a_2p95>;
> +	vccq-supply = <&vreg_l26a_1p2>;
> +	vccq2-supply = <&vreg_s4a_1p8>;
> +	vcc-max-microamp = <750000>;
> +	vccq-max-microamp = <560000>;
> +	vccq2-max-microamp = <750000>;
> +};
> +
> +&ufsphy {
> +	status = "ok";
> +	vdda-phy-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l2a_1p2>;
> +	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
> +	vdda-phy-max-microamp = <51400>;
> +	vdda-pll-max-microamp = <14600>;
> +	vddp-ref-clk-max-microamp = <100>;
> +	vddp-ref-clk-always-on;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index d291b4713c33..10e7b8a55b8a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -264,6 +264,11 @@
>   		rpm_requests: rpm-requests {
>   			compatible = "qcom,rpm-msm8998";
>   			qcom,glink-channels = "rpm_requests";
> +
> +			rpmcc: qcom,rpmcc {
> +				compatible = "qcom,rpmcc-msm8998";
> +				#clock-cells = <1>;
> +			};
>   		};
>   	};
>   
> @@ -686,5 +691,79 @@
>   			redistributor-stride = <0x0 0x20000>;
>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   		};
> +
> +		ufshc: ufshc@1da4000 {
> +			compatible = "qcom,msm8998-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0x1da4000 0x2500>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufsphy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			power-domains = <&gcc UFS_GDSC>;
> +
> +			clock-names =
> +				"core_clk",
> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"core_clk_ice",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk",
> +				"rx_lane1_sync_clk";
> +			clocks =
> +				<&gcc GCC_UFS_AXI_CLK>,
> +				<&gcc GCC_AGGRE1_UFS_AXI_CLK>,
> +				<&gcc GCC_UFS_AHB_CLK>,
> +				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
> +				<&gcc GCC_UFS_ICE_CORE_CLK>,
> +				<&rpmcc 0>,
> +				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
> +				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
> +			freq-table-hz =
> +				<50000000 200000000>,
> +				<0 0>,
> +				<0 0>,
> +				<37500000 150000000>,
> +				<75000000 300000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>;
> +
> +			resets = <&gcc GCC_UFS_BCR>;

I dunno how much this factors into your issues, but the resets defined 
in gcc-msm8998.c are wrong.  I'm posting a patch later today.  I know 
this was a problem for me with USB.

> +			reset-names = "rst";
> +
> +			status = "disabled";
> +		};
> +
> +		ufsphy: phy@1da7000 {
> +			compatible = "qcom,sdm845-qmp-ufs-phy";
> +			reg = <0x1da7000 0x18c>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clock-names =
> +				"ref_clk_src",
> +				"ref_clk",
> +				"ref_aux_clk";
> +			clocks =
> +				<&rpmcc 0>,
> +				<&gcc GCC_UFS_CLKREF_CLK>,
> +				<&gcc GCC_UFS_PHY_AUX_CLK>;
> +
> +			status = "disabled";
> +
> +			ufsphy_lanes: lanes@1da7400 {
> +				reg = <0x1da7400 0x108>,
> +				      <0x1da7600 0x1e0>,
> +				      <0x1da7c00 0x1dc>,
> +				      <0x1da7800 0x108>,
> +				      <0x1da7a00 0x1e0>;
> +				#phy-cells = <0>;
> +			};
> +		};
>   	};
>   };
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 850c02a52248..12a0a2d6ec7b 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -611,10 +611,25 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
>   	.num_clks = ARRAY_SIZE(msm8996_clks),
>   };
>   
> +/* msm8998 */
> +#define LN_BB_CLK1_ID 0x1
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, ln_bb_clk1, ln_bb_a_clk1, LN_BB_CLK1_ID);
> +
> +static struct clk_smd_rpm *msm8998_clks[] = {
> +	[0] = &msm8998_ln_bb_clk1,
> +	[1] = &msm8998_ln_bb_a_clk1,
> +};
> +
> +static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
> +	.clks = msm8998_clks,
> +	.num_clks = ARRAY_SIZE(msm8998_clks),
> +};
> +
>   static const struct of_device_id rpm_smd_clk_match_table[] = {
>   	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
>   	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
>   	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
> +	{ .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
