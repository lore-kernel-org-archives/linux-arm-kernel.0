Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CECC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03321A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bh6pHHMR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ge/iLjf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03321A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=smpZFyofh6T0EsXl1Go+Yc0srHHPnaZdnxDHT5TSnpw=; b=Bh6pHHMRGJcHwhJ4UqzZNL+7+
	7uJ670nTW3FPrEyaFAu+mgXuCwD7weMo+k5GLKqnGa4kxSQ7mAELZvSmsIkRoKAYdMb6QxBXXiXFK
	wod4cfAexAvQNYnyGxYoEtFQybrs9EI4AUETCmWidD11dPv/OnSzQL0J3qq67qTBWFgFAIVb2FeAM
	XIq4f2CN8BHufuIO1ej12qD2Po8OhMwqa8IsenmdG9Rsm1u38LXip+fStY9Y6B8IrP2RrgsVamn/d
	lCOqf7VcWx6ZkZxY4EeOLkNQrwoVk1XRWPxK7h/Jc6BmkJZYX9HujRTsnw9ci5WteBQtJDLUv0jY8
	tY5RaTNaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZAN-0004dF-Lm; Fri, 15 Feb 2019 08:48:15 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZ9z-0004L4-44
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:47:53 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8loxG012681;
 Fri, 15 Feb 2019 02:47:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550220470;
 bh=Hvyaajb+MHjAv7ncOUByb/REVL+23wPdwzLOY+aeQvk=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=ge/iLjf4U1pKxjcxR9TuvOs+gEyDWoLnxUgsBpIdrnPRDcCnpO72VVrvuGUZQrnKE
 HFNHM39tQo2m6HvHuCmLbWpNLDG8zsXcOBjUV7QvNlt4hZj2Zq/kpUeQURv18wjRWX
 dI938Y1x3T8G/BCFIFRVLBEqRj+kC3EAwhsz9r6M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8loqN036647
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 02:47:50 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:47:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:47:49 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8ll80020171;
 Fri, 15 Feb 2019 02:47:48 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: Add ADC nodes
To: Vignesh R <vigneshr@ti.com>
References: <20190212122237.10976-1-vigneshr@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <53e9327d-e941-820e-d83c-d6c5ccf25e26@ti.com>
Date: Fri, 15 Feb 2019 10:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212122237.10976-1-vigneshr@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004751_375824_FA6A2A02 
X-CRM114-Status: GOOD (  18.24  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/02/2019 14:22, Vignesh R wrote:
> TI AM654 SoC has two ADC instances in the MCU domain. Add DT nodes for
> the same.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> Tero,
> 
> Could you also pick up DT bindings here: https://patchwork.kernel.org/patch/10751429/
> All the Acks are in place.

Queued for 5.1, including the dt-binding.

Thanks, Tero

> 
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 30 +++++++++++++++++++
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts | 12 ++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 593f718e8fb5..6f7d2b316ded 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -57,4 +57,34 @@
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   	};
> +
> +	tscadc0: tscadc@40200000 {
> +		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
> +		reg = <0x0 0x40200000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 0 2>;
> +		assigned-clocks = <&k3_clks 0 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am654-adc", "ti,am3359-adc";
> +		};
> +	};
> +
> +	tscadc1: tscadc@40210000 {
> +		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
> +		reg = <0x0 0x40210000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 1 2>;
> +		assigned-clocks = <&k3_clks 1 2>;
> +		assigned-clock-rates = <60000000>;
> +		clock-names = "adc_tsc_fck";
> +
> +		adc {
> +			#io-channel-cells = <1>;
> +			compatible = "ti,am654-adc", "ti,am3359-adc";
> +		};
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index e41fc3a5987b..fb6df5c8f85b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -163,3 +163,15 @@
>   		#size-cells= <1>;
>   	};
>   };
> +
> +&tscadc0 {
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
