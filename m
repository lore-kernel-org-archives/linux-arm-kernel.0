Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11199C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:00:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36CD2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="duGWENFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36CD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTyFsjehWmKIFvGN66EYbhMs0Igulr14ZpDSie52WlA=; b=duGWENFgdKtD+HES3E7LKgcgE
	dbg3/sJH090voC4lxK/9ch+ONHXS+hOcvdJ8fVfme8ela/69PwDzrMU11hIel+4RySdiAy9y+wJF6
	xBQ9cwPs+OMsBIpwGYCDRhKrjnBvqd3R8mWmgPtERjuIo5dD3pbOf6LbuSIgbLdfvQlHRisLmyt/Z
	bTwUCHj+UCVVQWIDDg+BpW3d94PQflc4/+NbcnO/3GPy9KtPqP3cyANLQt7AHZXTpsc8dC3ivVnJY
	lim9ieMcMJ4ui+FT8byYfxUmoBaQpv2dr/1akxv0s9E83udPJj6dC8DbFVBSh8yigaR8rvgHYg2SG
	nHlmU1y7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWmS-0000TU-OB; Wed, 05 Dec 2018 12:59:56 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWmO-0000SK-KL; Wed, 05 Dec 2018 12:59:54 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gUWm9-0001lF-Cw from Akash_Gajjar@mentor.com ;
 Wed, 05 Dec 2018 04:59:37 -0800
Received: from [10.105.2.145] (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4;
 Wed, 5 Dec 2018 12:59:32 +0000
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rockpro64 fix regulator gpios
To: Oskari Lemmela <oskari@lemmela.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>
References: <20181201100817.20688-1-oskari@lemmela.net>
 <20181201100817.20688-2-oskari@lemmela.net>
From: agajjar <Akash_Gajjar@mentor.com>
Message-ID: <cf83adce-85cf-2251-6e50-3c87c8a01a0c@mentor.com>
Date: Wed, 5 Dec 2018 18:29:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181201100817.20688-2-oskari@lemmela.net>
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_045952_671145_4E87BA39 
X-CRM114-Status: GOOD (  20.97  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 12/1/2018 3:38 PM, Oskari Lemmela wrote:
> Rockpro64 is not able boot if GPIO1_C1 pin is pulled high
> before loading linux kernel.
>
> In rockpro64 GPIO1_C1 pin is connected vdd_cpu_b regulator
> VSEL pin. Pin should be pulled down in normal operation and
> pulled high in suspend.
>
> PMIC LDO_REG2 is connected to touch panel connector.
> Rename regulator and set it to correct voltage.
>
> PCIe power is controller by GPIO1_D0.
>
> Schematics can be downloaded from:
> http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Acked-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
>   .../boot/dts/rockchip/rk3399-rockpro64.dts    | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index 1d35f5406b5e..5bd4d69914bd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -97,7 +97,7 @@
>   	vcc3v3_pcie: vcc3v3-pcie-regulator {
>   		compatible = "regulator-fixed";
>   		enable-active-high;
> -		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pcie_pwr_en>;
>   		regulator-name = "vcc3v3_pcie";
> @@ -293,12 +293,12 @@
>   				};
>   			};
>   
> -			vcc2v8_dvp: LDO_REG2 {
> -				regulator-name = "vcc2v8_dvp";
> +			vcc3v0_touch: LDO_REG2 {
> +				regulator-name = "vcc3v0_touch";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
>   				regulator-state-mem {
>   					regulator-off-in-suspend;
>   				};
> @@ -397,7 +397,9 @@
>   	vdd_cpu_b: regulator@40 {
>   		compatible = "silergy,syr827";
>   		reg = <0x40>;
> -		fcs,suspend-voltage-selector = <0>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel1_gpio>;
>   		regulator-name = "vdd_cpu_b";
>   		regulator-min-microvolt = <712500>;
>   		regulator-max-microvolt = <1500000>;
> @@ -415,6 +417,8 @@
>   		compatible = "silergy,syr828";
>   		reg = <0x41>;
>   		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel2_gpio>;
>   		regulator-name = "vdd_gpu";
>   		regulator-min-microvolt = <712500>;
>   		regulator-max-microvolt = <1500000>;
> @@ -519,7 +523,7 @@
>   
>   	pcie {
>   		pcie_pwr_en: pcie-pwr-en {
> -			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
>   
> @@ -529,7 +533,7 @@
>   		};
>   
>   		vsel1_gpio: vsel1-gpio {
> -			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
>   		};
>   
>   		vsel2_gpio: vsel2-gpio {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
