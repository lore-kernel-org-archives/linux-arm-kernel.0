Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D218C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:27:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE0E20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WxQVbccM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+e8iOtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE0E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ng+/aOWaP4PB0wt8yXnkhx6A6h00/48+e/DU5d5yrgo=; b=WxQVbccMqBk6VK
	nBgnUJnYlkmIZu1wu9oBuzbdG4quEBETmvHBVmGd8jinkUY+qLh9KZdigD2AzaDNQ9pvz4HN57hly
	jiNFiYeLMhYwsaX6LKFSclcAgbjiTn9Pe0U7t4L2Aja1BYn5KSmFHRZV8np2anJNPz+RJrLQEa1TM
	QkvEhKbi2FMPrgnlGB9y00Fu8reAIajm3nVVkX/XDZ4DmrQfVth0kX7aLELuMnUAssa96E2+r1ARm
	FSfYIyGyojAgFFGpkN6L8GH7+PZ6C0CWpRhmfRfJJE3nhoJoj5MUW6JWKUUZlQZpJxy1xKXIjDrqA
	K8wiY7grzeI23SJmNYQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFY2-0001kq-1D; Fri, 22 Feb 2019 18:27:46 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFXy-0001jH-BJ
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:27:44 +0000
Received: by mail-pl1-x642.google.com with SMTP id m10so1441987plt.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Uusg/Uxs6yMAEhTeDMTAlNNExid37wE84jUbICMHDWU=;
 b=R+e8iOtXlpwpwW/cdn4RPfZRPKFzQ2snQRD4TRT9EbcCcQnfjwIx2sJ7v63v72lYaN
 xJ5PdVH6RmUufBt1kxUaDLgf/mcYf3w1mvU/j8JrSUibUM0wrwfE1Y0EPFbKeDBzmER3
 ElZll4naagXzHrt2OPPt3/MHhJkkytc27TWds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Uusg/Uxs6yMAEhTeDMTAlNNExid37wE84jUbICMHDWU=;
 b=Y3dPnxe4DJILh/u0P7aidp5ueXAK2s202y2LXEmTW85baym+UXMu7/KcGnKxO56c/U
 7iHwTaVEcb6I7m3fL4ASdnluQaRD/7tG4yiQreJljklFMM4Z8RpwlGD8QDQffVEc99i8
 Z9xeRUatfEKRI6S2o38yCyUuxSS2BS2BHSK+YG/PxVwBB9LEMoWMb4E80RoDO/20EEMX
 aPbsCwTtwj58/oOToHNKkD9CCShaaB+RUkK/CKc7w3xUe1vgp9RYEoIVWrbg1h5glc7Q
 V8rZjhUBN8RSjIRpcHl5iY+bbhXX/ctxEklGbcDbVm9K6w5RQQAUmEj4cwZUqsgj0QFz
 3c2A==
X-Gm-Message-State: AHQUAuaA+XYph1er9qIX+cvhxeA8OLutVl0h6Yf3E6IociVITsN0luhc
 in9OeiBMolWXvi/fMJtqTOFGRg==
X-Google-Smtp-Source: AHgI3Iase7M0desDXFaQ9G7kJPmTDoFmJGbzw0cFVyYRVkZ96UpdUBgDXKYqgwa0O4EsqI8/Fb/pOA==
X-Received: by 2002:a17:902:9341:: with SMTP id
 g1mr5601113plp.80.1550860061704; 
 Fri, 22 Feb 2019 10:27:41 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id l22sm3743987pfj.179.2019.02.22.10.27.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 10:27:41 -0800 (PST)
Date: Fri, 22 Feb 2019 10:27:40 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into
 its USB node
Message-ID: <20190222182740.GC223791@google.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-3-briannorris@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222003403.128243-3-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_102742_396043_2832C06C 
X-CRM114-Status: GOOD (  24.36  )
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, linux-arm-kernel@lists.infradead.org,
 Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 04:34:03PM -0800, Brian Norris wrote:
> Currently, we don't coordinate BT USB activity with our handling of the
> BT out-of-band wake pin, and instead just use gpio-keys. That causes
> problems because we have no way of distinguishing wake activity due to a
> BT device (e.g., mouse) vs. the BT controller (e.g., re-configuring wake
> mask before suspend). This can cause spurious wake events just because
> we, for instance, try to reconfigure the host controller's event mask
> before suspending.
> 
> We can avoid these synchronization problems by handling the BT wake pin
> directly in the btusb driver -- for all activity up until BT controller
> suspend(), we simply listen to normal USB activity (e.g., to know the
> difference between device and host activity); once we're really ready to
> suspend the host controller, there should be no more host activity, and
> only *then* do we unmask the GPIO interrupt.
> 
> This is already supported by btusb; we just need to describe the wake
> pin in the right node.
> 
> We list 2 compatible properties, since both PID/VID pairs show up on
> Scarlet devices, and they're both essentially identical QCA6174A-based
> modules.
> 
> Also note that the polarity was wrong before: Qualcomm implemented WAKE
> as active high, not active low. We only got away with this because
> gpio-keys always reconfigured us as bi-directional edge-triggered.
> 
> Finally, we have an external pull-up and a level-shifter on this line
> (we didn't notice Qualcomm's polarity in the initial design), so we
> can't do pull-down. Switch to pull-none.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is also required to make this stable, but since it's not
> really tied to the device tree, and it's an existing bug, I sent it
> separately:
> 
>   https://lore.kernel.org/patchwork/patch/1044896/
>   Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
> 
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 13 ++++++
>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 46 ++++++++++++-------
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 13 ------
>  3 files changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index c400be64170e..931640e9aed4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -200,6 +200,19 @@
>  		pinctrl-0 = <&bl_en>;
>  		pwm-delay-us = <10000>;
>  	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake_l>;
> +
> +		wake_on_bt: wake-on-bt {
> +			label = "Wake-on-Bluetooth";
> +			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +	};
>  };
>  
>  &ppvar_bigcpu {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> index fc50b3ef758c..3e2196c08473 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> @@ -175,6 +175,21 @@
>  		pinctrl-0 = <&dmic_en>;
>  		wakeup-delay-ms = <250>;
>  	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pen_eject_odl>;
> +
> +		pen-insert {
> +			label = "Pen Insert";
> +			/* Insert = low, eject = high */
> +			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <SW_PEN_INSERTED>;
> +			linux,input-type = <EV_SW>;
> +			wakeup-source;
> +		};
> +	};
>  };
>  
>  /* pp900_s0 aliases */
> @@ -328,20 +343,6 @@ camera: &i2c7 {
>  		<400000000>;
>  };
>  
> -&gpio_keys {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
> -
> -	pen-insert {
> -		label = "Pen Insert";
> -		/* Insert = low, eject = high */
> -		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> -		linux,code = <SW_PEN_INSERTED>;
> -		linux,input-type = <EV_SW>;
> -		wakeup-source;
> -	};
> -};
> -
>  &i2c_tunnel {
>  	google,remote-bus = <0>;
>  };
> @@ -437,8 +438,19 @@ camera: &i2c7 {
>  	status = "okay";
>  };
>  
> -&wake_on_bt {
> -	gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> +&usb_host0_ohci {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	qca_bt: bt@1 {
> +		compatible = "usb0cf3,e300", "usb04ca,301a";
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake_l>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "wakeup";
> +	};
>  };

I didn't know it was possible to configure (certain) USB devices
through the DT, neat!

>  
>  /* PINCTRL OVERRIDES */
> @@ -455,7 +467,7 @@ camera: &i2c7 {
>  };
>  
>  &bt_host_wake_l {
> -	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
> +	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_none>;
>  };
>  
>  &ec_ap_int_l {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index ea607a601a86..da03fa9c5662 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -269,19 +269,6 @@
>  		#clock-cells = <0>;
>  	};
>  
> -	gpio_keys: gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l>;
> -
> -		wake_on_bt: wake-on-bt {
> -			label = "Wake-on-Bluetooth";
> -			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> -			linux,code = <KEY_WAKEUP>;
> -			wakeup-source;
> -		};
> -	};
> -
>  	max98357a: max98357a {
>  		compatible = "maxim,max98357a";
>  		pinctrl-names = "default";

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
