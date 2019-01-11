Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:42:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8CB20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jsDuQAsv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tjCUvZnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8CB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uuLYA0ZdZBMJLvslnLjPjgbY/5vRQAEPL5Yb6WXgQrM=; b=jsDuQAsvXf110n
	yIGgJLRM/pHZ/exMQQYy4EVohSeryLBFEy6HUuLJZPdMo+BNAzLkThZ7pxGzW9FdLCFJBHgDLMdFu
	yRhqwz8z5ZQMG2GTnM03C1VkSXCDvLmrfPNrSkSVwd+WVwwlfrj/L5++/63DYudhotqfK4wJ/BsLJ
	or60QzxvqxgD5f3sOmLeGR1P3QT+9lQxDcqFql2km+ZuZlNljNLA2F2fzxxRqrl5bi5ejyW7eDmXi
	2H39XgQc+k1F36I6a68HRaUrWttRgFggcRsLTlAg7VwpmJT20GtLHDWAwZSHs3fxcyCx2q1H0wys/
	EBuUmHpf5OcF8xNuIbtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0oh-0004Um-Hx; Fri, 11 Jan 2019 17:41:59 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0od-0004UC-Lj
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:41:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=XUowxWRSd2Y+Sn0A7nY0q29L7H0oWBllzuWs6LBcrZs=; 
 b=tjCUvZnDgaMQQ3HMiUaRNU9TuGqDaHW0o0ksC2KJb64VGuXO2WIYg2cVuO1rNLcUYtpEdZWCLp1Ss8cxT+LiVgxDdl3m9hsyBA+QPOEN6TNn3lhWWSfuiaZ9wCDo5NdDJknBqfYYz29cgxf0mbyL+8nqKCdVRWK7nE6Bf0lb69Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gi0oV-0002fS-Gn; Fri, 11 Jan 2019 18:41:47 +0100
Date: Fri, 11 Jan 2019 18:41:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH] arm64: dts: marvell: Add device tree for uDPU board
Message-ID: <20190111174147.GG20924@lunn.ch>
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111172055.30451-1-vladimir.vid@sartura.hr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_094155_859903_648B7FBB 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
 Paul Arola <paul.arola@telus.com>, Luis Torres <luis.torres@methode.com>,
 Scott Roberts <scott.roberts@telus.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> new file mode 100644
> index 000000000000..eae30322a037
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device tree for the uDPU board.
> + * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
> + * Copyright (C) 2016 Marvell
> + * Copyright (C) 2018 Methode
> + * Copyright (C) 2018 Telus
> + *
> + * Vladimir Vid <vladimir.vid@sartura.hr>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model = "Methode uDPU Board";
> +	compatible = "marvell,armada-3720-db", "marvell,armada3720",
> +		     "marvell,armada3710";
> +

Hi Vladimir

There should be a compatible string here for the board. It looks like
you will also need to add Methode as a vendor to
Documentation/devicetree/bindings/vendor-prefixes.txt.

> +	leds {
> +		pinctrl-names = "default";
> +		compatible = "gpio-leds";
> +
> +		led@487 {
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +			default-state = "off";

It is normal to have a name here, indicating what the LED is for, its
colour, etc.

> +&mdio {
> +	status = "okay";
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};

These don't appear to be used anywhere. 

      Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
