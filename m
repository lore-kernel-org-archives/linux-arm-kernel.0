Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD964C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:53:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A0A21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WRPJPq2f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="LPER5UJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A0A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MRKPTqQgNJT9G185wHqqG4S5mrwQdcyaB52MY1049hI=; b=WRPJPq2f34v3/c
	uXIe4R5rdqAHZU/2TC+LlI9/dDCRpzaJqIg0pSwlP31sybG5gwAX/4FhV0sZNfjXv5GEGp3CMEynY
	f0COD6PVxx4sw0AV88tndDG/c/mSIWJThZO8p0cd1WaDwl4z9Wqs++LaixRqV0odY9CfIxxf0Zb0Z
	/7Ce85BeGUQmdms7X0TA9OJBBRggHOj1RDODjMFO0EQCr0RmF0VOio+Mu1gxp+IrTnLmB6hTSmSko
	w3WIl/id7Vam8LeyFNN9+fLegclx18T3pf5LJGvnmsm2ynFRhQd1uikG4l7PrTpPCyr5gANbiKabB
	N19e1zKXu1WWwYFgesRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxQo-0004eR-Pz; Tue, 22 Jan 2019 14:53:38 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxQk-0004e4-W7
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:53:37 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id AA5385C0072;
 Tue, 22 Jan 2019 15:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1548168810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nytjyd97V7nibdyJjfrhGG/2AIH00/JlriYdguPAV0k=;
 b=LPER5UJ9+o9iBGvtBzI8MZs4uRP7lWt46+LJkd0UMOBYlqeecg7Ema68jaVflyy7CyV+Et
 293idn9DGDUbL8BFK9fv1nxtrgfsnB4pG0E6EG7fNkhyD3tNZ7gfwxtwfwItcNJKVEGL8H
 6QasopEa2gUzHCwx/ZVJmRnO+6MK+sY=
MIME-Version: 1.0
Date: Tue, 22 Jan 2019 15:53:30 +0100
From: Stefan Agner <stefan@agner.ch>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH 1/2] ARM: dts: Add stmpe-adc DT node to Toradex iMX6
 modules
In-Reply-To: <20190122132135.5012-2-dev@pschenker.ch>
References: <20190122132135.5012-1-dev@pschenker.ch>
 <20190122132135.5012-2-dev@pschenker.ch>
Message-ID: <959c74d19959e0cf2261df7f3deaf536@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_065335_477688_1A941F5C 
X-CRM114-Status: GOOD (  14.71  )
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
 Pengutronix Kernel Team <kernel@pengutronix.de>, marcel.ziswiler@toradex.com,
 s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 NXP Linux Team <linux-imx@nxp.com>, max.krummenacher@toradex.com,
 linux-tegra@vger.kernel.org, shawnguo@kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 22.01.2019 14:21, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add the stmpe-adc DT node as found on Toradex iMX6 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> ---
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 22 ++++++++++++++--------
>  2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 8380f1b26826..e8c7ef7e078a 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -332,11 +332,17 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -346,17 +352,17 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* forbid to use ADC channels 3-0 (touch) */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..eb8603a2444e 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -262,11 +262,17 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -276,17 +282,17 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* forbid to use ADC channels 3-0 (touch) */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
