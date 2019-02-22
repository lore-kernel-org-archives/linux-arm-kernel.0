Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97778C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CDA2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UL+BPm5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CDA2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v99eDlwskjud4h50Jam5MmzSlHnW2TUUxQVIqVT1xGo=; b=UL+BPm5KM1HDwt
	e38mZ9LX2l2c5tB/E66DI0uHUS2W4sGgjLR5EZHo3KdCQTrTO+gU/O+FijoiCddDPpLYabKIkOj/N
	egKxIpYCur1tPXk5Aj1hdznppt2Uj4jZO0xNJTgshmzXU/X/vGFSPNMFZ2qj28BO1A014QqTlzINQ
	VrdDg5B9RYB+H9X/yDVM1kpzLhCbiVrtXKJUtEW7etb547Gz2hdLrwoq+2sPm16D2GJwuRPr6rag/
	EYpxHs+YRaYRc68OncQxzoP4MaIo4sOfaML4gDkwK+gDV+eByK/YdgmSu5FMYfs833yk8a11f1aol
	QbG/9ijsgk3Cg7ATHWSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGqp-0003uE-2E; Fri, 22 Feb 2019 19:51:15 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGql-0003tG-OF
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:51:13 +0000
Received: by mail-oi1-f195.google.com with SMTP id z14so2689651oid.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TSFIG56rRaaFfYgbdNZzBbOmDSAD7TjsHwVZFadjdx4=;
 b=FtXS9MJ3ifQ+q7X8hgh3mofaFd4bFKohHQ8r0ZR+DRZQnk4XSsiLud/DFcrw4ReC5X
 QoWhFQtwqSv8CDEZuj0tVvi38G+yXRN2H4LP/WzWgYZtUQuD6CJK246Bz1XOO1cVjMeV
 rRyOG31Ss3AtIW1NEGouc2jlJMjRFAhepNAHS0nwocNDTjO+gXMsqe4kXKehAg0fQor+
 G4XJwMIYAov0OfStF9n2u8BWiDqXVr/qwTXtUah7vK8bBMMxRYI1oF0LVFmlavfK577/
 /WWJFmYLI/NDwguGEAjRzhHOHMFVSFjGsLIxWpmsjT9swpNOrlyXmZ4GR/gV9DYVTR+D
 qMnA==
X-Gm-Message-State: AHQUAuaBsTM/gCbq9AY/zWNW/pfysFCaYWYmSV0gSE50kks/uHzx+g48
 Azno7MSubeeCIOU7jKVq4A==
X-Google-Smtp-Source: AHgI3Ib5QB9sUqWKJ4hxH0pZ5cJnnIE5sDA3QvAJ8WCHqErgBGesZ8rKJvh9AauGidqSxgvYiozCuQ==
X-Received: by 2002:aca:ed81:: with SMTP id l123mr3400240oih.139.1550865070695; 
 Fri, 22 Feb 2019 11:51:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h67sm950667otb.36.2019.02.22.11.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 11:51:10 -0800 (PST)
Date: Fri, 22 Feb 2019 13:51:09 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Mavrodiev <stefan@olimex.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: leds: Add binding for axp20x-led
 device driver
Message-ID: <20190222195109.GA17753@bogus>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-4-stefan@olimex.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215115013.11098-4-stefan@olimex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_115111_795648_6AD607A1 
X-CRM114-Status: GOOD (  20.08  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS"
 <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee.jones@linaro.org>,
 "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 01:50:08PM +0200, Stefan Mavrodiev wrote:
> This adds the devicetree bindings for charge led indicator found
> on most of X-Powers AXP20X PMICs.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
> new file mode 100644
> index 000000000000..5a83ad06796d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
> @@ -0,0 +1,74 @@
> +Device Tree Bindings for LED support on X-Powers PMIC
> +
> +Most of the X-Powers PMICs have integrated battery charger with LED indicator.
> +The output is open-drain, so the state is either high-Z or output-low. The
> +driver is a subnode of AXP20X MFD driver, since it uses shared bus with all
> +other cells.
> +The LED can be controlled either manually or automatically. Then in automatic
> +(controlled by the charger) there are two indication modes:
> +
> +Mode-A
> +======
> +- output-low:		Charging
> +- high-Z		Not charging
> +- 1Hz flashing:		Abnormal alarm
> +- 4Hz flashing		Overvoltage alarm
> +
> +Mode-B
> +======
> +- output-low:		Battery full
> +- high-Z		Not charging
> +- 1Hz flashing:		Charging
> +- 4Hz flashing		Overvoltage or abnormal alarm
> +
> +The control and the mode can be changed from sysfs.
> +
> +For AXP20X MFD bindings see:
> +Documentation/devicetree/bindings/mfd/axp20x.txt
> +
> +Required properties:
> +- compatible : Must be "x-powers,axp20x-led"
> +
> +Supported common LED properties, see ./common.txt for more informationn
> +- label : See Documentation/devicetree/bindings/leds/common.txt
> +- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
> +- default-state: See Documentation/devicetree/bindings/leds/common.txt
> +
> +Optional properties:
> +- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
> +			 If omitted, then the control is set to manual mode.
> +			 On invalid value, Mode-A is used.
> +
> +
> +Example:
> +
> +	axp803: pmic@3a3 {
> +		compatible = "x-powers,axp803";
> +
> +		...
> +
> +		led@0 {

What's the 0 for? A unit address without a reg property is not valid.

> +			compatible = "x-powers,axp20x-led";
> +			status = "okay";
> +
> +			label = "axp20x:yellow:chgled";
> +			linux,default-trigger = "timer";
> +			default-state = "on";
> +		};
> +	};
> +
> +or
> +
> +	axp803: pmic@3a3 {
> +		compatible = "x-powers,axp803";
> +
> +		...
> +
> +		led@0 {
> +			compatible = "x-powers,axp20x-led";
> +			status = "okay";
> +
> +			label = "axp20x:yellow:chgled";
> +			x-powers,charger-mode = <1>;
> +		};
> +	};
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
