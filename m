Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAE6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB3820652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="acvh63z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB3820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dt5DtSLr5Oeitq7N72RmjcTo9wG9X9CDaiSvadDLZ+Q=; b=acvh63z4IGHax9
	S3Bb7oawrufTAzcr28oKawI+/Vvq3yFas1dNuQcgJ+hpCi8vgY5sl2Kt5GwOFMkPb/kHVyDYOdqfP
	KCuqsO0qzlevN6OS6Xl0oF0GUchsHWTl0gA0jZA5e0HVvegr8abKFdip7REnM7KDyFPdNhGmiWau5
	OoXrtD6q0kjqshkv5U53mVnZGbMiQvPB+PkaQGGaUaRqd5dx48FgRd82CEeRVEgVPcFlhCRCJKvSx
	tIkPkp8p/Tj6vlQO9tAivTx9klgJP3mAY9o14It3wtSEuR9DZYp0qziTUCUCXfZwvnnXGQe5jD8uF
	S9V1lZn00DvFmjy7AfeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvibs-0006Nw-U9; Mon, 18 Feb 2019 13:05:24 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvibp-0006N3-4K; Mon, 18 Feb 2019 13:05:23 +0000
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de
 [79.249.243.97])
 by mail.holtmann.org (Postfix) with ESMTPSA id F4131CF2C7;
 Mon, 18 Feb 2019 14:13:04 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/6] dt-bindings: net: bluetooth: add support for MediaTek
 MT7663U and MT7668U UART devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
Date: Mon, 18 Feb 2019 14:05:11 +0100
Message-Id: <0EF74A38-3D1F-4BD1-9B72-78E8720C125D@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_050521_320778_66DE9DBA 
X-CRM114-Status: GOOD (  14.67  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 linux-mediatek@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

> Update binding document with adding support of MT7663U and MT7668U UART
> devices to mediatek-bluetooth.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> .../bindings/net/mediatek-bluetooth.txt       | 64 +++++++++++++++++++
> 1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> index 14ceb2a5b4e8..41a7dcc80f5b 100644
> --- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> @@ -33,3 +33,67 @@ Example:
> 			clock-names = "ref";
> 		};
> 	};
> +
> +MediaTek UART based Bluetooth Devices
> +==================================
> +
> +This device is a serial attached device to UART device and thus it must be a
> +child node of the serial node with UART.
> +
> +Please refer to the following documents for generic properties:
> +
> +	Documentation/devicetree/bindings/serial/slave-device.txt
> +
> +Required properties:
> +
> +- compatible:	Must be
> +		  "mediatek,mt7663u-bluetooth": for MT7663U device
> +		  "mediatek,mt7668u-bluetooth": for MT7668U device
> +- vcc-supply:	Main voltage regulator
> +- pinctrl-names: Should be "default", "runtime"
> +- pinctrl-0: Should contain UART RXD low when the device is powered up to
> +	     enter proper bootstrap mode.
> +- pinctrl-1: Should contain UART mode pin ctrl
> +
> +Optional properties:
> +
> +- reset-gpios:	GPIO used to reset the device whose initial state keeps low,
> +		if the GPIO is missing, then board-level design should be
> +		guaranteed.
> +- current-speed:  Current baud rate of the device whose defaults to 921600
> +
> +Example:
> +
> +	uart1_pins_boot: uart1-default {
> +		pins-dat {
> +			pinmux = <MT7623_PIN_81_URXD1_FUNC_GPIO81>;
> +			output-low;
> +		};
> +	};
> +
> +	uart1_pins_runtime: uart1-runtime {
> +		pins-dat {
> +			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
> +				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
> +		};
> +	};
> +
> +	uart1: serial@11003000 {
> +		compatible = "mediatek,mt7623-uart",
> +			     "mediatek,mt6577-uart";
> +		reg = <0 0x11003000 0 0x400>;
> +		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_UART1_SEL>,
> +			 <&pericfg CLK_PERI_UART1>;
> +		clock-names = "baud", "bus";
> +
> +		bluetooth {
> +			compatible = "mediatek,mt7663u-bluetooth";
> +			vcc-supply = <&reg_5v>;
> +			reset-gpios = <&pio 24 GPIO_ACTIVE_LOW>;
> +			pinctrl-names = "default", "runtime";
> +			pinctrl-0 = <&uart1_pins_boot>;
> +			pinctrl-1 = <&uart1_pins_runtime>;
> +			current-speed = <921600>;
> +		};
> +	};

can you ACK this please.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
