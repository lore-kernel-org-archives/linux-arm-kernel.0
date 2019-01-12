Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52697C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:13:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D5A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pddZkE5O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8/C60Fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D5A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+GaZnUKOI+uSYQKFWRmkjioeV/azkWl6FobXEyb5yOw=; b=pddZkE5OS4sf33
	jGKrg6mNYdmTH0akSoyyzjotnVbqGkHOBq5zDizhsrv2M0RKRWCFwmJg80ieWHsjqm/vNaeswGFZg
	TKyzOtwlNUYc2FlzI8OpkmcGkSG5JqpC9qHmOG/eBRpVDkfHmC1PA3AJf6EXXLaRdqKInJbvsSw7i
	5rG5sVDY/8f9an/je8oXnbgE8BNHjqdU3hMDwDWY/Cj1kYp2ngXYCfBOdmPHzff3Nx4bATm/0T1rE
	JZBJWMacAXxgggkBXUJ9z1kDUsfla+sTHBQMUu5YteZnXThBAeLJ7HT81wpmtc/X9zz38X5BAXaf8
	MO83gYE1DwD0qXdW5wzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9js-0005aO-6o; Sat, 12 Jan 2019 03:13:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9jo-0005a2-Ge
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 03:13:34 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D242220851;
 Sat, 12 Jan 2019 03:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547262812;
 bh=1+x1ahWlyF0A9XSXhcyKa5JTnj+Vv2MQv33Igjq1dBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L8/C60FktfM0gErIE/c7iT3WRaqYH2HeEj3v7SbMHunhQ8pQyw95VI9kTEzASBMjG
 oqWno6DN+f61S2Kz/tFTsXRggO++JAam0sQWtOjwa/dsGTUyZ588GrY9zkQ3HQrDw4
 /qcA6pJbkrfLJzGCAKwNbJjFmwdp84vgMMZylLyE=
Date: Sat, 12 Jan 2019 11:13:19 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 3/4] ARM: dts: imx6qdl-phytec-pfla02: Replace magic numbers
Message-ID: <20190112031318.GT32649@dragon>
References: <20181223163141.6792-1-shc_work@mail.ru>
 <20181223163141.6792-3-shc_work@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181223163141.6792-3-shc_work@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_191332_571689_98675A70 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 07:31:40PM +0300, Alexander Shiyan wrote:
> Use GPIO_ACTIVE_LOW/HIGH for GPIO description.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> index 211640e..81007d6 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -23,7 +23,7 @@
>  			regulator-name = "usb_otg_vbus";
>  			regulator-min-microvolt = <5000000>;
>  			regulator-max-microvolt = <5000000>;
> -			gpio = <&gpio4 15 0>;
> +			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
>  		};
>  
> @@ -33,7 +33,7 @@
>  			regulator-name = "usb_h1_vbus";
>  			regulator-min-microvolt = <5000000>;
>  			regulator-max-microvolt = <5000000>;
> -			gpio = <&gpio1 0 0>;
> +			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
>  		};
>  	};
> @@ -43,12 +43,12 @@
>  
>  		green {
>  			label = "phyflex:green";
> -			gpios = <&gpio1 30 0>;
> +			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
>  		};
>  
>  		red {
>  			label = "phyflex:red";
> -			gpios = <&gpio2 31 0>;
> +			gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
>  };
> @@ -69,7 +69,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi3>;
>  	status = "okay";
> -	cs-gpios = <&gpio4 24 0>;
> +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;

GPIO_ACTIVE_LOW is defined as 1 rather than 0.

Shawn

>  
>  	flash@0 {
>  		compatible = "m25p80", "jedec,spi-nor";
> -- 
> 2.10.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
