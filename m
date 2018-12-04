Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D91C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:23:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305332082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bshUSnKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305332082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bGOnUdrKz0Yn2JItjy6zc0U8gVCSadMPbmxaA5xpH/4=; b=bshUSnKntDeIut
	pc4kas886ktt2Mxb2pFw7vzFaOQBuNE4t0SjncFcTA1l0l5dmhVoGkTc1o+exg74922mYeJCwq7Jm
	m6MC0L0LLaIgZXewQQxBC8SMg/AUCuPUggLxQo4BzHLfcUC/Qj42FO17NuKyO0veD/1dMcBNB57UX
	3+ZRpkQw/LFP6SfPY2tnTR8yRvkNG/GPqNGVq9BwuHn/NG6nCbCbuX9LjFhO6vaYiEgyAaA/x5PlL
	S13Cf/R+6ahy6wCSpYiNEn803SlspjGGt7bd0vMZWLiAl5zOQ+7PZZ7GpC/MQZJ4exRR4dDOsHfsi
	xcWvT79kkbYuOnNRT7BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUK1m-0000Iy-RT; Tue, 04 Dec 2018 23:22:54 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUK1i-0000Gc-HZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 23:22:52 +0000
Received: by mail-ot1-f65.google.com with SMTP id k98so16928252otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 15:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FAbEasdJLd9uvlN46AwjM1ksyg5eRKVQUx73eR+hOAE=;
 b=i/8DLBw5h8MGhLjAzDT9Gsu7dGr+CVU9nDk6B4pKgx+3W8uLetgnnUI0R2ykcItYB5
 KyTf9lyGvLEKb0YAhUuNQIUgC0DgRpcCan1He2jh04rLoCOQEdiI4B/BMLyAPSGmQsah
 N4PAykxTGQQIYRGbpZX8muez5Zfhs6BW7BBl6BY1NX+VfL+usfhF3cVlix901GfBipaB
 CTNT4Yq46HpKeYVjhbcgaDZgILQQ9wwK5TodtFlwyRRlTageyqxtvDATWDhX8SO0oSr0
 lB6iFmEP+f15euh9oGaGuhj+PwUZLSA7ZD17gC6uD+lgGnxU3kyZP0JM7Van6Xxz8Stl
 GoNg==
X-Gm-Message-State: AA+aEWbXd+FLts40kc9o6orj24irrseUAfADoqulBOEnTj7LxsHpCUBi
 SZ2dY6fqX/HOFmJEDWxf/ZLhJJs=
X-Google-Smtp-Source: AFSGD/W6Rnj0oMMeDpql9fV6OZPm8z+RN6y342jDYDbFMg/N82gO7kHfoPrfyfFhdRXcB9HBsEEK/A==
X-Received: by 2002:a9d:501:: with SMTP id 1mr14826969otw.133.1543965758757;
 Tue, 04 Dec 2018 15:22:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m133sm7676946oib.52.2018.12.04.15.22.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 15:22:37 -0800 (PST)
Date: Tue, 4 Dec 2018 17:22:37 -0600
From: Rob Herring <robh@kernel.org>
To: Andrei.Stefanescu@microchip.com
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Message-ID: <20181204232237.GA16883@bogus>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_152250_580506_C1BA7596 
X-CRM114-Status: GOOD (  22.03  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org,
 Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 20, 2018 at 08:08:36AM +0000, Andrei.Stefanescu@microchip.com wrote:
> This patch describes the compatible and the device tree
> bindings necessary for the SAMA5D2 PIOBU GPIO.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>  .../bindings/gpio/gpio-sama5d2-piobu.txt           | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> new file mode 100644
> index 0000000..2e260e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt

microchip,sama5d2-piobu.txt for the file name.

> @@ -0,0 +1,31 @@
> +GPIO controller for SAMA5D2 PIOBU pins.
> +
> +These pins have the property of not losing their voltage
> +during Backup/Self-refresh mode.
> +
> +These bindings should be set to a node in the dtsi file.
> +
> +Required properties:
> +- compatible:		"syscon", "microchip,sama5d2-piobu"

syscon should be removed.

> +- #gpio-cells:		There are 2. The pin number is the
> +			first, the second represents additional
> +			parameters such as GPIO_ACTIVE_HIGH/LOW.
> +- gpio-controller:	Marks the port as GPIO controller.
> +
> +Note that the driver uses syscon and should be the child of
> +the syscon node.

child of the "atmel,sama5d2-secumod" node to be more specific.

But why do you need a child node? The parent can be a gpio provider. 
What other nodes does this need?

> +
> +Example:
> +
> +	secumod@fc040000 {
> +		compatible = "atmel,sama5d2-secumod", "syscon", "simple-mfd";

This is not documented as being a simple-mfd.

> +		status = "okay";
> +		reg = <0xfc040000 0x100>;
> +
> +		pioBU: piobu {

gpio {

Is there not a register range you can put here?

> +			status = "okay";
> +			compatible = "microchip,sama5d2-piobu";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +	};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
