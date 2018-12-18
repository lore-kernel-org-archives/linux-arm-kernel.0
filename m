Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C637C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:56:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C29921841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nAS8V91+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iOwW06kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C29921841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=markX41y8+zytqIS3F7ExFHi6jRcOuQ80ayMx+br1xk=; b=nAS8V91+oRJuov
	Na7tVc30/MUU3pFZCsf9iIZ9kN/GpvbYdMhHtUv7oK3yI80EEYhgxVuDkHn+wzmkzNDqzug4DAW2G
	OzJx732iV9QUjKw1h6RMwHhU2gv8C4HdhJSRHexCfpLztmX6DJ1Mcvq1q7J7gm4K0Oe8COoNNadtF
	A+I/HQSyH3mk2F7R3uYALs0kRCddIm6JCRwaoWpeQ/QZrm4YcvczShvEk+VF4qWu8CiKQtirOLITA
	7JxUwzKfB0o0eEQ5AWryqLCcpl64rqPjNitVw8QdNOPMnDgolL2+Caadka9GWu9kDK6FGM6eeOh87
	a+nc6So5W4tXq3AGeWzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZC7V-00057h-JJ; Tue, 18 Dec 2018 09:56:57 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZC7S-000555-5J
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:56:55 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18c4540000>; Tue, 18 Dec 2018 01:56:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 01:56:41 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 18 Dec 2018 01:56:41 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:56:39 +0000
Subject: Re: [PATCH V3 01/20] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-2-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <38524148-ff37-b07e-7a86-a457b3be108e@nvidia.com>
Date: Tue, 18 Dec 2018 09:56:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218091232.23532-2-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545126996; bh=wD15X9lNCKrYzghob8iYNOy2r3GRQ5n7ZYIpH2j6t9E=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=iOwW06kvsPPkS4caLfQ4ZhtuV2c3VgubVx7saBurGQ0pHaDmhAV7j41uDHNnuTvS3
 zZZypv/HqiN9L7r/rxS7VIvZP7PqRqAqJHVLfxDBwdqV/6JjCcxJxk7crjoJMzLIMS
 P3owdswhsnANEdvUx9tTd6Za+O/9S+5Ki2aN/Xb4YlH67x6KzmhCnywuixex16JOsG
 9BPFMmZE+p+Bg5P3GU0c/jcCq3VWaoo+g1z6joV3aCIAIh/kZO+mNZBmQVwvvgvG+H
 9LRScPav5jxD5FexLKh1dbo5j91OzQZyVIDBT/H+9wR6J9UnSpUbeGK1Iive2jwybQ
 ZEcQQG/xt8yzg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_015654_214198_28646C34 
X-CRM114-Status: GOOD (  22.18  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 18/12/2018 09:12, Joseph Lo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Add new properties to configure the DFLL PWM regulator support.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V3:
>  - no change
> *V2:
>  - update the binding strings and descriptions for
>  nvidia,pwm-tristate-microvolts
>  nvidia,pwm-min-microvolts
>  nvidia,pwm-voltage-step-microvolts
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt   | 79 ++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> index dff236f524a7..38e8cc8c70a8 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> @@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
>  oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
>  control module that will automatically adjust the VDD_CPU voltage by
>  communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
> -Currently only the I2C mode is supported by these bindings.
>  
>  Required properties:
>  - compatible : should be "nvidia,tegra124-dfll"
> @@ -45,10 +44,31 @@ Required properties for the control loop parameters:
>  Optional properties for the control loop parameters:
>  - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
>  
> +Optional properties for mode selection:
> +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
> +
>  Required properties for I2C mode:
>  - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
>  
> -Example:
> +Required properties for PWM mode:
> +- nvidia,pwm-period: period of PWM square wave in microseconds.
> +- nvidia,pwm-tristate-microvolts: Regulator voltage in micro volts when PWM
> +  control is disabled and the PWM output is tristated. Note that this voltage is
> +  configured in hardware, typically via a resistor divider.
> +- nvidia,pwm-min-microvolts: Regulator voltage in micro volts when PWM control
> +  is enabled and PWM output is low. Hence, this is the minimum output voltage
> +  that the regulator supports when PWM control is enabled.
> +- nvidia,pwm-voltage-step-microvolts: Voltage increase in micro volts
> +  corresponding to a 1/33th increase in duty cycle. Eg the voltage for 2/33th
> +  duty cycle would be: nvidia,pwm-min-microvolts +
> +  nvidia,pwm-voltage-step-microvolts * 2.
> +- pinctrl-0: I/O pad configuration when PWM control is enabled.
> +- pinctrl-1: I/O pad configuration when PWM control is disabled.
> +- pinctrl-names: must include the following entries:
> +  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
> +  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
> +
> +Example for I2C:
>  
>  clock@70110000 {
>          compatible = "nvidia,tegra124-dfll";
> @@ -76,3 +96,58 @@ clock@70110000 {
>  
>          nvidia,i2c-fs-rate = <400000>;
>  };
> +
> +Example for PWM:
> +
> +clock@70110000 {
> +	compatible = "nvidia,tegra124-dfll";
> +	reg = <0 0x70110000 0 0x100>, /* DFLL control */
> +	      <0 0x70110000 0 0x100>, /* I2C output control */
> +	      <0 0x70110100 0 0x100>, /* Integrated I2C controller */
> +	      <0 0x70110200 0 0x100>; /* Look-up table RAM */
> +	interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&tegra_car TEGRA210_CLK_DFLL_SOC>,
> +	         <&tegra_car TEGRA210_CLK_DFLL_REF>,
> +		 <&tegra_car TEGRA124_CLK_I2C5>;;
> +	clock-names = "soc", "ref", "i2c";
> +	resets = <&tegra_car TEGRA124_RST_DFLL_DVCO>;
> +	reset-names = "dvco";
> +	#clock-cells = <0>;
> +	clock-output-names = "dfllCPU_out";
> +
> +	nvidia,sample-rate = <25000>;
> +	nvidia,droop-ctrl = <0x00000f00>;
> +	nvidia,force-mode = <1>;
> +	nvidia,cf = <6>;
> +	nvidia,ci = <0>;
> +	nvidia,cg = <2>;
> +
> +	nvidia,pwm-min-microvolts = <708000>; /* 708mV */
> +	nvidia,pwm-period = <2500>; /* 2.5us */
> +	nvidia,pwm-to-pmic;
> +	nvidia,pwm-tristate-microvolts = <1000000>;
> +	nvidia,pwm-voltage-step-microvolts = <19200>; /* 19.2mV */
> +
> +	pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
> +	pinctrl-0 = <&dvfs_pwm_active_state>;
> +	pinctrl-1 = <&dvfs_pwm_inactive_state>;
> +};
> +
> +/* pinmux nodes added for completeness. Binding doc can be found in:
> + * Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
> + */
> +
> +pinmux: pinmux@700008d4 {
> +	dvfs_pwm_active_state: dvfs_pwm_active {
> +		dvfs_pwm_pbb1 {
> +			nvidia,pins = "dvfs_pwm_pbb1";
> +			nvidia,tristate = <TEGRA_PIN_DISABLE>;
> +		};
> +	};
> +	dvfs_pwm_inactive_state: dvfs_pwm_inactive {
> +		dvfs_pwm_pbb1 {
> +			nvidia,pins = "dvfs_pwm_pbb1";
> +			nvidia,tristate = <TEGRA_PIN_ENABLE>;
> +		};
> +	};
> +};
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
