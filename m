Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E12C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA98821104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZcFmX+8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA98821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m9a4XeSUBab6uKjoWXm8lSAwySt8XvGC+tcm+xjl0t8=; b=ZcFmX+8LUDhSFi
	rEYYRUE0eE1SA/q7G4oy1hVkzfI6bLrFA1cxLGenbKns82f8v6vD7oVoXoZlgSXKZuzu6MWZMaYXO
	ijoVwTVL7WSkNaqTg59U/xR0ahX6J4SU8wCq4AFplYpJZYDJMSB5gGKrdl0wgubv0o2SpgH+VgZ7r
	I5FOvjHTGrLJkb9OZHGwWhT6VVARaL7Lmvv/wXvK0hQDhZ+XSkhyJ5Po4s+9uPgX60dOi0EHqOtdX
	FT1UbQYjximu/YdUBAp/nA2pX4aRhzJCxWahoqxy/LzONiYj7kILQ841fJhhATQuqdt+BcrDrH6ZU
	WYbvftdrJ0qwx0SSNNdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOb4-0004pu-TP; Thu, 13 Dec 2018 10:52:03 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOaz-0004p1-O3
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:52:00 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4025913F7F0;
 Thu, 13 Dec 2018 11:51:25 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Jeffrey Hugo <jhugo@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <bea2710e-729f-d3c9-8d62-28cf642ab827@free.fr>
Message-ID: <f904b64e-1dd6-97a8-554a-e38acf4636a2@free.fr>
Date: Thu, 13 Dec 2018 11:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bea2710e-729f-d3c9-8d62-28cf642ab827@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_025158_091673_19A4C04C 
X-CRM114-Status: GOOD (  21.00  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 18:34, Marc Gonzalez wrote:

> On 03/12/2018 16:18, Marc Gonzalez wrote:
> 
>> I'm trying to enable UFS on apq8098. Just wanted to share my progress
>> so far, in case someone spots any glaring mistakes.
> 
> I feel I'm close, but I'm still missing something. Full boot log and
> complete diff provided below, for reference.
> 
> I'm open to suggestions :-)

I'll try doing an auto-review, looking for anything suspicious.

> (Maybe I went overboard with the defconfig changes, I'll try reverting
> to the default one.)

Same issue with the default defconfig, so probably not relevant.


> [    0.000000] ITS: No ITS available, not enabling LPIs

Could it be that LPIs are required for the UFS HW block? (I doubt it.)

> LPIs are typically used for peripherals that produce message-based
> interrupts. An LPI targets only one core at a given time. LPIs are
> generated when the peripheral writes to the ITS, which also holds the
> registers to control the generation and maintenance of LPIs. The ITS
> provides interrupt ID translation, allowing peripherals to be owned
> directly by a virtual machine if a System MMU is also present for
> those peripherals.


> [    0.317814] s1: supplied by vph_pwr
> [    0.318299] s2: supplied by vph_pwr
> [    0.318548] s3: supplied by vph_pwr
> [    0.318613] s3: Bringing 0uV into 1352000-1352000uV
> [    0.319113] s4: supplied by vph_pwr
> [    0.319172] s4: Bringing 0uV into 1800000-1800000uV
> [    0.319463] s5: supplied by vph_pwr
> [    0.319511] s5: Bringing 0uV into 1904000-1904000uV
> [    0.319827] s6: supplied by vph_pwr
> [    0.320150] s7: supplied by vph_pwr
> [    0.320198] s7: Bringing 0uV into 900000-900000uV
> [    0.320426] s8: supplied by vph_pwr
> [    0.320690] s9: supplied by vph_pwr
> [    0.320912] s10: supplied by vph_pwr
> [    0.321197] s11: supplied by vph_pwr
> [    0.321401] s12: supplied by vph_pwr
> [    0.321611] s13: supplied by vph_pwr
> [    0.321931] l1: supplied by s7
> [    0.321985] l1: Bringing 0uV into 880000-880000uV
> [    0.322228] l2: supplied by s3
> [    0.322277] l2: Bringing 0uV into 1200000-1200000uV
> [    0.322516] l3: supplied by s7
> [    0.322652] l3: Bringing 0uV into 1000000-1000000uV
> [    0.322922] l4: supplied by s7
> [    0.323107] l5: supplied by s7
> [    0.323161] l5: Bringing 0uV into 800000-800000uV
> [    0.323440] l6: supplied by s5
> [    0.323591] l6: Bringing 0uV into 1808000-1808000uV
> [    0.323884] l7: supplied by s5
> [    0.323931] l7: Bringing 0uV into 1800000-1800000uV
> [    0.324210] l8: supplied by s3
> [    0.324254] l8: Bringing 0uV into 1200000-1200000uV
> [    0.324514] l9: Bringing 0uV into 1808000-1808000uV
> [    0.324897] l10: Bringing 0uV into 1808000-1808000uV
> [    0.325302] l11: supplied by s7
> [    0.325360] l11: Bringing 0uV into 1000000-1000000uV
> [    0.325640] l12: supplied by s5
> [    0.325709] l12: Bringing 0uV into 1800000-1800000uV
> [    0.325982] l13: Bringing 0uV into 1808000-1808000uV
> [    0.326310] l14: supplied by s5
> [    0.326449] l14: Bringing 0uV into 1880000-1880000uV
> [    0.326738] l15: supplied by s5
> [    0.326792] l15: Bringing 0uV into 1800000-1800000uV
> [    0.327078] l16: Bringing 0uV into 2704000-2704000uV
> [    0.327375] l17: supplied by s3
> [    0.327447] l17: Bringing 0uV into 1304000-1304000uV
> [    0.327858] l18: Bringing 0uV into 2704000-2704000uV
> [    0.328191] l19: Bringing 0uV into 3008000-3008000uV
> [    0.328497] l20: Bringing 0uV into 2960000-2960000uV
> [    0.328934] l21: Bringing 0uV into 2960000-2960000uV
> [    0.329293] l22: Bringing 0uV into 2864000-2864000uV
> [    0.329638] l23: Bringing 0uV into 3312000-3312000uV
> [    0.329989] l24: Bringing 0uV into 3088000-3088000uV
> [    0.330502] l25: Bringing 0uV into 3104000-3104000uV
> [    0.330949] l26: supplied by s3
> [    0.331004] l26: Bringing 0uV into 1200000-1200000uV
> [    0.331404] l27: supplied by s7
> [    0.331748] l28: Bringing 0uV into 3008000-3008000uV
> [    0.332157] lvs1: supplied by s4
> [    0.333678] lvs2: supplied by s4
> [    0.334967] bob: supplied by vph_pwr
> [    0.335041] bob: Bringing 0uV into 3312000-3312000uV

AFAICT, UFS (HC+PHY) requires l20, l26, s4 + l1, l2
It doesn't say 'supplied by X' for l20. Might be an issue...


> [    0.954299] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.15
> [    0.954431] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.16
> [    0.955131] qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy

AFAIU, this means the UFS PHY is working correctly, and has been initialized
successfully (so clocks, regulators, ... everything checks out?)


> [    2.083564] ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled

Troubling, but same downstream.
And <&gcc UFS_GDSC> should be enabled by power-domains = <&gcc UFS_GDSC>; (need to check)

> [    2.083793] MYDEBUG: ufshcd_parse_pinctrl_info=0
> [    2.093295] ufshcd_init_clocks: core_clk max=200000000
> [    2.098008] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk, rate: 198400000
> [    2.102953] ufshcd_init_clocks: bus_aggr_clk max=0
> [    2.111164] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: bus_aggr_clk, rate: 198400000
> [    2.115881] ufshcd_init_clocks: iface_clk max=0
> [    2.124443] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: iface_clk, rate: 0

Odd.

> [    2.128812] ufshcd_init_clocks: core_clk_unipro max=150000000
> [    2.136439] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 148800000
> [    2.142280] ufshcd_init_clocks: core_clk_ice max=300000000
> [    2.151106] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
> [    2.156425] ufshcd_init_clocks: ref_clk max=0
> [    2.164288] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 19200000
> [    2.168661] ufshcd_init_clocks: tx_lane0_sync_clk max=0
> [    2.176449] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: tx_lane0_sync_clk, rate: 0
> [    2.181691] ufshcd_init_clocks: rx_lane0_sync_clk max=0
> [    2.189988] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane0_sync_clk, rate: 0
> [    2.195135] ufshcd_init_clocks: rx_lane1_sync_clk max=0
> [    2.203443] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane1_sync_clk, rate: 0

No tx1, odd.

> [    2.208761] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk enabled
> [    2.216923] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk enabled
> [    2.224471] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk enabled
> [    2.232457] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro enabled
> [    2.240441] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice enabled
> [    2.248840] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk enabled
> [    2.256426] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
> [    2.264064] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
> [    2.272654] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
> [    2.281262] l20: supplied by bob

Aha, here's the 'supplied by X' for l20. Could it be too late? (Unlikely)

> [    2.289650] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.34
> [    2.292778] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.40
> [    2.299441] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.5

Need to check whether these regulators are enabled/functional.

> [    2.309977] scsi host0: ufshcd
> [    2.314021] MYDEBUG: ufshcd_assert_device_reset
> [    2.316332] MYDEBUG: ufshcd_deassert_device_reset

OK, so the ufs_reset pin should be deasserted at this point.

> [    2.347478] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0

Same log downstream.

> [    2.348407] ufshcd_wait_for_dev_cmd: time_left=8
> [    2.364079] ufshcd_wait_for_dev_cmd = 0

So the very first command succeeds (tag 31, same as the commands that fail below).


> [    3.872668] ufshcd_wait_for_dev_cmd: time_left=0
> [    3.872757] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
> [    3.876423] ufshcd_wait_for_dev_cmd = -11
> [    3.885185] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
> [    3.889102] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 0
> [    3.964264] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000000
> [    4.027895] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000000
> [    4.098358] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000001

> [    5.408617] ufshcd_wait_for_dev_cmd: time_left=0
> [    5.408666] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
> [    5.412355] ufshcd_wait_for_dev_cmd = -11
> [    5.421097] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
> [    5.425042] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 1

> [    6.944607] ufshcd_wait_for_dev_cmd: time_left=0
> [    6.944657] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
> [    6.948345] ufshcd_wait_for_dev_cmd = -11
> [    6.957084] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
> [    6.961029] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 2
> [    6.970576] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
> [    6.979368] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init setting fDeviceInit flag failed with error -11

And then the next 3 commands fail by timing out (tag 31 still).
So the driver throws its hands in the air, and gives up.



> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index b4276da1fb0d..e1c87de39076 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -241,3 +241,49 @@
>  		};
>  	};
>  };
> +
> +&ufshc {
> +	status = "ok";
> +/***	vdd-hba-supply = <&gcc UFS_GDSC>;	-EPROBE_DEFER ***/
> +	pinctrl-names = "dev-reset-assert", "dev-reset-deassert";
> +	pinctrl-0 = <&ufs_dev_reset_assert>;
> +	pinctrl-1 = <&ufs_dev_reset_deassert>;
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
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +	ufs_dev_reset_assert: ufs_dev_reset_assert {
> +		config {
> +			pins = "ufs_reset";
> +			bias-pull-down;
> +			drive-strength = <8>;
> +			output-low;
> +		};
> +	};
> +	ufs_dev_reset_deassert: ufs_dev_reset_deassert {
> +		config {
> +			pins = "ufs_reset";
> +			bias-pull-down;
> +			drive-strength = <8>;
> +			output-high;
> +		};
> +	};
> +};

Copied from downstream. Will triple-check...


> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 78227cce16db..03ba269f5440 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -3,11 +3,12 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
>  
> -	qcom,msm-id = <292 0x0>;
> +	qcom,msm-id = <319 0x20001>;
>  
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> @@ -264,6 +265,11 @@
>  		rpm_requests: rpm-requests {
>  			compatible = "qcom,rpm-msm8998";
>  			qcom,glink-channels = "rpm_requests";
> +
> +			rpmcc: qcom,rpmcc {
> +				compatible = "qcom,rpmcc-msm8998";
> +				#clock-cells = <1>;
> +			};
>  		};
>  	};
>  
> @@ -686,5 +692,75 @@
>  			redistributor-stride = <0x0 0x20000>;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
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

Need to check this.

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
> +				<&rpmcc RPM_SMD_BB_CLK1>,

Is that the right prop/phandle/offset?

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
> +			reset-names = "rst";

Evan/Bjorn said this is unused. Need to check.

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
> +			clock-names = "ref", "ref_aux";
> +			clocks =
> +				<&gcc GCC_UFS_CLKREF_CLK>,
> +				<&gcc GCC_UFS_PHY_AUX_CLK>;

Make sure these clocks are prepared/enabled.

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
>  	};
>  };
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 850c02a52248..be072897a80d 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -611,10 +611,113 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
>  	.num_clks = ARRAY_SIZE(msm8996_clks),
>  };
>  
> +/* QCS404 */
> +DEFINE_CLK_SMD_RPM_QDSS(qcs404, qdss_clk, qdss_a_clk, QCOM_SMD_RPM_MISC_CLK, 1);
> +
> +DEFINE_CLK_SMD_RPM(qcs404, pnoc_clk, pnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
> +DEFINE_CLK_SMD_RPM(qcs404, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
> +
> +DEFINE_CLK_SMD_RPM(qcs404, bimc_clk, bimc_a_clk, QCOM_SMD_RPM_MEM_CLK, 0);
> +DEFINE_CLK_SMD_RPM(qcs404, bimc_gpu_clk, bimc_gpu_a_clk, QCOM_SMD_RPM_MEM_CLK, 2);
> +
> +DEFINE_CLK_SMD_RPM(qcs404, qpic_clk, qpic_a_clk, QCOM_SMD_RPM_QPIC_CLK, 0);
> +DEFINE_CLK_SMD_RPM(qcs404, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
> +
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(qcs404, rf_clk1, rf_clk1_a, 4);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(qcs404, rf_clk1_pin, rf_clk1_a_pin, 4);
> +
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(qcs404, ln_bb_clk, ln_bb_a_clk, 8);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(qcs404, ln_bb_clk_pin, ln_bb_clk_a_pin, 8);
> +
> +static struct clk_smd_rpm *qcs404_clks[] = {
> +	[RPM_SMD_QDSS_CLK] = &qcs404_qdss_clk,
> +	[RPM_SMD_QDSS_A_CLK] = &qcs404_qdss_a_clk,
> +	[RPM_SMD_PNOC_CLK] = &qcs404_pnoc_clk,
> +	[RPM_SMD_PNOC_A_CLK] = &qcs404_pnoc_a_clk,
> +	[RPM_SMD_SNOC_CLK] = &qcs404_snoc_clk,
> +	[RPM_SMD_SNOC_A_CLK] = &qcs404_snoc_a_clk,
> +	[RPM_SMD_BIMC_CLK] = &qcs404_bimc_clk,
> +	[RPM_SMD_BIMC_A_CLK] = &qcs404_bimc_a_clk,
> +	[RPM_SMD_BIMC_GPU_CLK] = &qcs404_bimc_gpu_clk,
> +	[RPM_SMD_BIMC_GPU_A_CLK] = &qcs404_bimc_gpu_a_clk,
> +	[RPM_SMD_QPIC_CLK] = &qcs404_qpic_clk,
> +	[RPM_SMD_QPIC_CLK_A] = &qcs404_qpic_a_clk,
> +	[RPM_SMD_CE1_CLK] = &qcs404_ce1_clk,
> +	[RPM_SMD_CE1_A_CLK] = &qcs404_ce1_a_clk,
> +	[RPM_SMD_RF_CLK1] = &qcs404_rf_clk1,
> +	[RPM_SMD_RF_CLK1_A] = &qcs404_rf_clk1_a,
> +	[RPM_SMD_LN_BB_CLK] = &qcs404_ln_bb_clk,
> +	[RPM_SMD_LN_BB_A_CLK] = &qcs404_ln_bb_a_clk,
> +};
> +
> +static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
> +	.clks = qcs404_clks,
> +	.num_clks = ARRAY_SIZE(qcs404_clks),
> +};
> +
> +/* msm8998 */
> +DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
> +DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
> +DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, div_clk1, div_clk1_a, 0xb);
> +DEFINE_CLK_SMD_RPM(msm8998, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk1, bb_clk1_a, 1);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk2, bb_clk2_a, 2);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, bb_clk3_pin, bb_clk3_a_pin, 3);
> +DEFINE_CLK_SMD_RPM(msm8998, mmssnoc_axi_rpm_clk, mmssnoc_axi_rpm_a_clk,
> +		   QCOM_SMD_RPM_MMAXI_CLK, 0);
> +DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
> +		   QCOM_SMD_RPM_AGGR_CLK, 1);
> +DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
> +		   QCOM_SMD_RPM_AGGR_CLK, 2);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk1, rf_clk1_a, 4);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
> +DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
> +static struct clk_smd_rpm *msm8998_clks[] = {
> +	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
> +	[RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
> +	[RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
> +	[RPM_SMD_CNOC_A_CLK] = &msm8998_cnoc_a_clk,
> +	[RPM_SMD_CE1_CLK] = &msm8998_ce1_clk,
> +	[RPM_SMD_CE1_A_CLK] = &msm8998_ce1_a_clk,
> +	[RPM_SMD_DIV_CLK1] = &msm8998_div_clk1,
> +	[RPM_SMD_DIV_A_CLK1] = &msm8998_div_clk1_a,
> +	[RPM_SMD_IPA_CLK] = &msm8998_ipa_clk,
> +	[RPM_SMD_IPA_A_CLK] = &msm8998_ipa_a_clk,
> +	[RPM_SMD_BB_CLK1] = &msm8998_bb_clk1,
> +	[RPM_SMD_BB_CLK1_A] = &msm8998_bb_clk1_a,
> +	[RPM_SMD_BB_CLK2] = &msm8998_bb_clk2,
> +	[RPM_SMD_BB_CLK2_A] = &msm8998_bb_clk2_a,
> +	[RPM_SMD_BB_CLK3_PIN] = &msm8998_bb_clk3_pin,
> +	[RPM_SMD_BB_CLK3_A_PIN] = &msm8998_bb_clk3_a_pin,
> +	[RPM_SMD_MMAXI_CLK] = &msm8998_mmssnoc_axi_rpm_clk,
> +	[RPM_SMD_MMAXI_A_CLK] = &msm8998_mmssnoc_axi_rpm_a_clk,
> +	[RPM_SMD_AGGR1_NOC_CLK] = &msm8998_aggre1_noc_clk,
> +	[RPM_SMD_AGGR1_NOC_A_CLK] = &msm8998_aggre1_noc_a_clk,
> +	[RPM_SMD_AGGR2_NOC_CLK] = &msm8998_aggre2_noc_clk,
> +	[RPM_SMD_AGGR2_NOC_A_CLK] = &msm8998_aggre2_noc_a_clk,
> +	[RPM_SMD_RF_CLK1] = &msm8998_rf_clk1,
> +	[RPM_SMD_RF_CLK1_A] = &msm8998_rf_clk1_a,
> +	[RPM_SMD_RF_CLK2_PIN] = &msm8998_rf_clk2_pin,
> +	[RPM_SMD_RF_CLK2_A_PIN] = &msm8998_rf_clk2_a_pin,
> +	[RPM_SMD_RF_CLK3] = &msm8998_rf_clk3,
> +	[RPM_SMD_RF_CLK3_A] = &msm8998_rf_clk3_a,
> +	[RPM_SMD_RF_CLK3_PIN] = &msm8998_rf_clk3_pin,
> +	[RPM_SMD_RF_CLK3_A_PIN] = &msm8998_rf_clk3_a_pin,
> +};
> +
> +static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
> +	.clks = msm8998_clks,
> +	.num_clks = ARRAY_SIZE(msm8998_clks),
> +};
> +
>  static const struct of_device_id rpm_smd_clk_match_table[] = {
>  	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
>  	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
>  	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
> +	{ .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
> +	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);

Jeffrey's RPMCC patch. Looks good.


> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> index 9f0ae403d5f5..621f1a66ce86 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -117,6 +117,17 @@ static const char * const gcc_parent_names_5[] = {
>  	"core_bi_pll_test_se",
>  };
>  
> +static struct clk_fixed_factor xo = {
> +	.mult = 1,
> +	.div = 1,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "xo",
> +		.parent_names = (const char *[]){ "xo_board" },
> +		.num_parents = 1,
> +		.ops = &clk_fixed_factor_ops,
> +	},
> +};
> +
>  static struct pll_vco fabia_vco[] = {
>  	{ 250000000, 2000000000, 0 },
>  	{ 125000000, 1000000000, 1 },
> @@ -1099,6 +1110,27 @@ static struct clk_rcg2 ufs_axi_clk_src = {
>  	},
>  };
>  
> +static const struct freq_tbl ftbl_ufs_unipro_core_clk_src[] = {
> +	F(37500000, P_GPLL0_OUT_MAIN, 16, 0, 0),
> +	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> +	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 ufs_unipro_core_clk_src = {
> +	.cmd_rcgr = 0x76028,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_ufs_unipro_core_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "ufs_unipro_core_clk_src",
> +		.parent_names = gcc_parent_names_1,
> +		.num_parents = 3,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
>  static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
>  	F(19200000, P_XO, 1, 0, 0),
>  	F(120000000, P_GPLL0_OUT_MAIN, 5, 0, 0),

My ufs_unipro_core_clk hack looks suspicious. Could someone check?
Will double check as well.


> @@ -1884,7 +1916,7 @@ static struct clk_branch gcc_gp3_clk = {
>  
>  static struct clk_branch gcc_gpu_bimc_gfx_clk = {
>  	.halt_reg = 0x71010,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x71010,
>  		.enable_mask = BIT(0),
> @@ -1972,6 +2004,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_hmss_dvm_bus_clk",
> +			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2015,6 +2048,7 @@ static struct clk_branch gcc_lpass_at_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_lpass_at_clk",
> +			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2401,7 +2435,7 @@ static struct clk_branch gcc_ufs_phy_aux_clk = {
>  
>  static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
>  	.halt_reg = 0x75014,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x75014,
>  		.enable_mask = BIT(0),
> @@ -2414,7 +2448,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
>  
>  static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
>  	.halt_reg = 0x7605c,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x7605c,
>  		.enable_mask = BIT(0),
> @@ -2427,7 +2461,7 @@ static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
>  
>  static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
>  	.halt_reg = 0x75010,
> -	.halt_check = BRANCH_HALT,
> +	.halt_check = BRANCH_HALT_SKIP,
>  	.clkr = {
>  		.enable_reg = 0x75010,
>  		.enable_mask = BIT(0),
> @@ -2438,6 +2472,8 @@ static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
>  	},
>  };
>  
> +static const char *foo[] = { "ufs_unipro_core_clk_src" };
> +
>  static struct clk_branch gcc_ufs_unipro_core_clk = {
>  	.halt_reg = 0x76008,
>  	.halt_check = BRANCH_HALT,
> @@ -2446,6 +2482,8 @@ static struct clk_branch gcc_ufs_unipro_core_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ufs_unipro_core_clk",
> +			.parent_names = foo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},

Suspicious here too.

My gut feeling is that something is broken in my version of the
clock driver. Will triple-check everything.

[big snip]

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
