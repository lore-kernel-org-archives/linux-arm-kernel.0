Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1BBC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:42:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EF3208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgbAXsFw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZxKX5Hq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EF3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9bBWh9O8HDkIKu+U9YczUd5qOmPCVM4WSqXN/u7sPm0=; b=PgbAXsFw/0S1kh
	p/5jy+o9zFiwcPYVeQitQNmvzAMBlGHFCooHy++hsn83QJbtqoGFMMWTUqcWBB844AbZXEhZU7kEA
	ZA7x8zAM/3QWJajNk5OCDiEy4WywqbpaNhLp/lsK6BZ6GMLt9ZNa2xCJG2OC8X9pLRZUW8bHWC64c
	CzaSOJYOO4v8oQhiNYX3Y18rKhiVB7D5SxYsnziEx/o3ExXiCPZAlYD4vbtYroB0+G7seE3DTmyWU
	tPbG6w4pI42jEbuc7JlLhjxDWIV8wHCZHfpzsgAZdpfY5YRH0aHAYVem0qypDuSDXhaOf+l1PKJ2/
	q7JpVyte5JZCM/ACyvww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGOX-00088P-8z; Fri, 07 Dec 2018 13:42:17 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGOT-0007tC-KF
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:42:15 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a789d0000>; Fri, 07 Dec 2018 05:41:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 05:42:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 05:42:02 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 13:41:59 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
Date: Fri, 7 Dec 2018 13:41:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-2-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544190110; bh=NOVIbH0JVcvaIKImHh2L8OnSBgGMegCkNALg40qunM4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ZxKX5Hq42YPRESlNZYHuMvTuVyVXKG+K2LKmDIUwCshyW1UkgajxLEGU56N4VpGZR
 5bvA/iBm1N7pLZ4jJ4cW3Lkj6XGKsqzUDLcAvv5TVLKBLCB54AVua8W79huLjn+Ahd
 LhR172tDLWA4MNhMCj5z923KNzP9B9YQJy4m0EXSpLuZWep56YJJvosg4PG5g0S5SJ
 9wdmD4/EYhVZJarrIABn3U9Qphk6BmIyultDYhZO8Nh6QOJXRW4+1wEO9mL9xNd4ag
 BfMEmHMVSSQVBokhYUIUV0wWffzX27UMabCepzbHzYLe1PsSFUzZeC/gM2dQi3lmny
 g8JKGNYhIOY7g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_054213_731173_3E1968FF 
X-CRM114-Status: GOOD (  17.39  )
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


On 04/12/2018 09:25, Joseph Lo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Add new properties to configure the DFLL PWM regulator support. Also
> add an example and make the I2C clock only required when I2C support is
> used.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt   | 73 ++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> index dff236f524a7..8c97600d2bad 100644
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
> @@ -45,10 +44,28 @@ Required properties for the control loop parameters:
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
> +- nvidia,init-uv: Regulator voltage in micro volts when PWM control is disabled.

Maybe consider 'pwm-inactive-voltage-microvolt'.

> +- nvidia,align-offset-uv: Regulator voltage in micro volts when PWM control is
> +			  enabled and PWM output is low.

Would this be considered the minimum pwm active voltage?

> +- nvidia,align-step-uv: Voltage increase in micro volts corresponding to a
> +			1/33th increase in duty cycle. Eg the voltage for 2/33th
> +			duty cycle would be:

Maybe consider 'pwm-voltage-step-microvolt'.

> +			nvidia,align-offset-uv + nvidia,align-step-uv * 2.
> +- pinctrl-0: I/O pad configuration when PWM control is enabled.
> +- pinctrl-1: I/O pad configuration when PWM control is disabled.
> +- pinctrl-names: must include the following entries:
> +  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
> +  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.

Please see Rob's feedback on the above [0].

Cheers
Jon

[0] https://lore.kernel.org/patchwork/patch/885328/

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
