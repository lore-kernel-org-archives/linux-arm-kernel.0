Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E3C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C7A2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTq+sSJV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MkFYpkYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C7A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d4lyzFUh71dtBYpGWnyepratZWeCLEoByJKEWCVwijw=; b=LTq+sSJVATr5Vy
	p/EK/dstZ/cuEVsen+aSHg06YdEQ1LgFVQzgIJqurHY4x68XcyuMo+V5p4dalUmANpiILsdPFYlik
	j/pCLwiHBw1cX8fUNSgwvbfwugnqKyQqWqemDZclJFQdDNfptljnxFpBILEfwe15MoU5YC2iQASmZ
	QNgtYqgDbArzDawatbRhmyholg6WfFdgW0Rerp0MOlVcEPbJjEgK/abbn8OXzDelMbJh3vRet84JL
	aWBtBsYk9MpD7ReER6beuk/rvWjv1gUvwXTp/4EC4mQ6Rt+0XLzVamtL7UV3VF/UfQKMDEDpwuu0G
	xWVdldO4UT3kUpEb9nXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLjA-0006cO-CA; Wed, 23 Jan 2019 16:50:12 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLj1-0005OD-GY
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:50:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id f188so29151wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=MsjGYbxSdxohzPgNJOgdJcG5Xj2r796U0cFued0EXik=;
 b=MkFYpkYcy4oZXYly9/PLBg0jVdJIwt2EkEgfCCBs4OgSLnZ1m7i0I/Re8efOfK1XBu
 KDs6M2KBa8KkT9/n0UFf85qJBXTgKnwAnJsoJf6TlN7pKUN+PXqTg4wvcwJKoM6PgIKO
 o0jyfroMpUlrGomUOztBa2EkmPO8f7JS9W1FpNSKFTskZrv2K0+0eBX7nRxk49zwf+aJ
 6RAJbpXuwCu6e6LECVBVvJUvVsCUivaVlhqev87+Og09ADRjZHacvR+D/eBHcbXd4BOK
 Tx498HcF/WhITEgMKO8Rvnxr92jSYcFdniqPXZhfBRqyBaW19LmSbqh5aLLZQcWzIb6r
 xRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=MsjGYbxSdxohzPgNJOgdJcG5Xj2r796U0cFued0EXik=;
 b=b0SitHEJ9kNlRUCD+K+rJpauI5H4LlRxCBhqF0Ls5jRnicCyMHj3ToPVcc/U1sOFdP
 uvkOQj3NngvNxLcPqViYGMrwAJwj1z07XbUNkyxIS+tfS3ArpUz4qIfp2yrA0f7jA5A6
 412lC7UVmwAqBUl1MK0rfqmle7t56KYxodMQTG/8DpAq1meoHJfo4BPJD56rsb87EOxX
 /5LO+Q3sqvwoh2eHEl4ybzGO8fuq73X5XC10lCVdKVmLeXURwfRkVDRg0XpZ3jriFsLn
 f3CWRXynEZfxw0Fsju7ZD+GqJOqtKs5sOmChd5BLyj1LE5Dp1ZstIPU27uZsEwX7G0C4
 ixFQ==
X-Gm-Message-State: AJcUukcK2ydNma0cJ9wKru5I3NTWDjSmlr7klPNiMIL4Bjt40J/pjpNm
 JVY6LrT7Uf0qQQgQ8YPCz8fQjw==
X-Google-Smtp-Source: ALg8bN76rDDh7Px17wGR3jvzg2ppwIBh0L0vXaAN8wCsbgjUfITkZQkDQLkP35IkeNSZGCxoQNH0vg==
X-Received: by 2002:a1c:43:: with SMTP id 64mr3612223wma.72.1548262201461;
 Wed, 23 Jan 2019 08:50:01 -0800 (PST)
Received: from localhost (aputeaux-684-1-20-21.w90-86.abo.wanadoo.fr.
 [90.86.223.21])
 by smtp.googlemail.com with ESMTPSA id w80sm82727567wme.38.2019.01.23.08.50.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 08:50:00 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
In-Reply-To: <20190113181808.5768-1-linux.amoon@gmail.com>
References: <20190113181808.5768-1-linux.amoon@gmail.com>
Date: Wed, 23 Jan 2019 08:49:59 -0800
Message-ID: <7hef93mi88.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_085003_563964_221E805E 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Emiliano Ingrassia <ingrassia@epigenesys.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Anand Moon <linux.amoon@gmail.com> writes:

> Add missing vbus-supply link to phy controller for usb_phy0
> and usb_phy1 nodes, this changes fixed the power issue
> on usb ports usb, changes help fix usb reset warning.
>
> [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch

As requested, dropping this series from the fixes branch pending further
debug and testing.

Kevin

> [alarm@archl-c1t ~]$ lsusb -t
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> [alarm@archl-c1t ~]$
> [alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
> Couldn't open device, some information will be missing
> Bus 001 Device 003: ID 1b71:0056 Fushicai
>     MaxPower              500mA
> Couldn't open device, some information will be missing
> Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
>     MaxPower               30mA
> Couldn't open device, some information will be missing
> Couldn't open device, some information will be missing
> Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
>     MaxPower              100mA
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     MaxPower                0mA
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 0f0a46ddf3ff..a49a8509b288 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -83,6 +83,19 @@
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> +	usb_vbus: regulator-usb-vbus {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "USB_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		vin-supply = <&p5v0>;
> +
> +		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	tflash_vdd: regulator-tflash_vdd {
>  		/*
>  		 * signal name from schematics: TFLASH_VDD_EN
> @@ -293,8 +306,18 @@
>  	pinctrl-names = "default";
>  };
>  
> +&usb0_phy {
> +	status = "okay";
> +	vbus-supply = <&usb_vbus>;
> +};
> +
>  &usb1_phy {
>  	status = "okay";
> +	vbus-supply = <&usb_vbus>;
> +};
> +
> +&usb0 {
> +	status = "okay";
>  };
>  
>  &usb1 {
> -- 
> 2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
