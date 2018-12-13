Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C6C67872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:00:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817642086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jovxM+DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817642086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bEZpE4Uo3ja84f3n5w9wrjWY+noQZcG2zGPHMhjX6aA=; b=jovxM+DOwTEDjoHmadrALbcKo
	hFPlZddYZYOW54steim9Z5qhLrW1fj0eQcYxyC2FTAT7aQP+AUw8cJlNIIMq1hCOhVYJFS8p8LFEx
	LhZqvoJ5FM8eUs0l8FqfP023Uw9lb7rsJ0xRN8PHkE5fg3Yyw6eiV1g2wPO9bkNArKZqLn2Dao0wu
	nmOyhruIKEsVpCkenUdOZ/YPer5zp7Ybx9ICOn0ZlmbacWoLK+O4pdw4f8MByRqCnITUQ+/dJ23bj
	3LqPa1nK7fqsfI6fyNF91w+aUe6HehYDgdThKsiXHhDj9OlRk/Z2pD2ovqhzApJOw894jpgvOanpQ
	qQrp5PORg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSTT-0002l7-HA; Thu, 13 Dec 2018 15:00:27 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSTP-0002kQ-TA
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:00:25 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBDF0Avr061567;
 Thu, 13 Dec 2018 09:00:10 -0600
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBDF0ANI034883
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Dec 2018 09:00:10 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 09:00:09 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 09:00:09 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBDF06Wm005904;
 Thu, 13 Dec 2018 09:00:06 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add McSPI DT nodes
To: Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20181209102222.7624-1-vigneshr@ti.com>
 <20181209102222.7624-2-vigneshr@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <7b718f70-bb74-0530-9566-d621371c3d13@ti.com>
Date: Thu, 13 Dec 2018 16:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181209102222.7624-2-vigneshr@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_070024_029930_FB4BE91F 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09/12/2018 12:22, Vignesh R wrote:
> There are 3 instances of McSPI in MCU domain and 4 instances in Main domain.
> Add DT nodes for all McSPI instances present on AM654 SoC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 52 ++++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 30 ++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 0a0a8fc5df64..6c71e67b8988 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -138,4 +138,56 @@
>   		clocks = <&k3_clks 39 0>;
>   		clock-names = "fck";
>   	};
> +
> +	main_spi0: spi@2100000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";

WARNING: DT compatible string "ti,am654-mcspi" appears un-documented -- 
check ../../Documentation/devicetree/bindings/
#63: FILE: arch/arm64/boot/dts/ti/k3-am65-main.dtsi:143:
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";

Same for the rest of the nodes.

Did you forget documentation part?

-Tero

> +		reg = <0x0 0x2100000 0x0 0x400>;
> +		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 137 1>;
> +		power-domains = <&k3_pds 137>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	main_spi1: spi@2110000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x2110000 0x0 0x400>;
> +		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 138 1>;
> +		power-domains = <&k3_pds 138>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		assigned-clocks = <&k3_clks 137 1>;
> +		assigned-clock-rates = <48000000>;
> +	};
> +
> +	main_spi2: spi@2120000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x2120000 0x0 0x400>;
> +		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 139 1>;
> +		power-domains = <&k3_pds 139>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	main_spi3: spi@2130000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x2130000 0x0 0x400>;
> +		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 140 1>;
> +		power-domains = <&k3_pds 140>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	main_spi4: spi@2140000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x2140000 0x0 0x400>;
> +		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 141 1>;
> +		power-domains = <&k3_pds 141>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 1fd027748e1f..1aeae52fb239 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -26,4 +26,34 @@
>   		clocks = <&k3_clks 114 1>;
>   		power-domains = <&k3_pds 114>;
>   	};
> +
> +	mcu_spi0: spi@40300000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x40300000 0x0 0x400>;
> +		interrupts = <GIC_SPI 560 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 142 1>;
> +		power-domains = <&k3_pds 142>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	mcu_spi1: spi@40310000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x40310000 0x0 0x400>;
> +		interrupts = <GIC_SPI 561 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 143 1>;
> +		power-domains = <&k3_pds 143>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	mcu_spi2: spi@40320000 {
> +		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
> +		reg = <0x0 0x40320000 0x0 0x400>;
> +		interrupts = <GIC_SPI 562 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 144 1>;
> +		power-domains = <&k3_pds 144>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
>   };
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
