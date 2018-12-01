Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D6C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:56:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5661B21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CqBUGQJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbX8xwn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5661B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aj70yfVxcdduqtbNEhc28iqySJrh3S1TZLG2WFf7WZM=; b=CqBUGQJBsFiLM2
	h56xdm9s5Y8ZZXUfo4TYBvmOl/t0xRF7tunI3/4cdKdK48eUA1NUSdFD91F71gYESRa36hITUp0bJ
	IhcBuB1HzFJfXbL0SkjizskxIr/bJjS3rkbXDkXtzMKqx2bBl7TlSW2gLIJolC+TGvSNNlbF7zkJ5
	1I5PYC8HS3TBI+w09HdEKgqR/t70A6W/hoNqRjO2NAO/uXprKSp35EpA/UQR+9Og0X2hpc7vWuwSX
	+dRQpcQt3dJyTL/SgaHF7i3MoM33757EQz47EJhFzWQ8FTsbUypqYW/pyQ1VhN+KyyIENvfjzOq9c
	cCFT6jo1LVYcWm83Pr+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT8Yx-0003Nu-Rl; Sat, 01 Dec 2018 16:56:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT8Ys-0003Md-W0; Sat, 01 Dec 2018 16:56:12 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 847092082F;
 Sat,  1 Dec 2018 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543683359;
 bh=GeoKvgjVymGufq/iewqE4t+0sAMIfjmrLMLh3VjTi4k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qbX8xwn7ffyiQLIxQisaOVAdzVc18Lx/NRoZe+e87RZv9lF6eEEsZiWMDqmKlKNsL
 YrKUvj+VijMa9mYZkkKtUM1lSuQfo9jHS95TZ2VCfYh/9tppFbd+npK+469VEoZw5t
 uTgAr/wlTOVShSlw1QKQOgfnQaw8CU8OpZdMuCMs=
Date: Sat, 1 Dec 2018 16:55:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
Message-ID: <20181201165550.51a78366@archlinux>
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_085611_064658_1442024D 
X-CRM114-Status: GOOD (  20.56  )
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
Cc: Milo Kim <milo.kim@ti.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-aspeed@lists.ozlabs.org,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Michal Simek <michal.simek@xilinx.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, kernel-usp@googlegroups.com,
 Lars-Peter Clausen <lars@metafoo.de>, linux-rockchip@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Joel Stanley <joel@jms.id.au>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-samsung-soc@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 linux-amlogic@lists.infradead.org, Lucas Santos <ilucas.ms@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Support Opensource <support.opensource@diasemi.com>,
 Scott Branden <sbranden@broadcom.com>, Andrew Jeffery <andrew@aj.id.au>,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Carlo Caione <carlo@caione.org>, Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 28 Nov 2018 15:53:12 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Lucas, Matheus,

Doing this as a large all at once patch may seem like a good idea, but...

Whilst it is now kernel policy (sort of) to use SPDX, that doesn't
correspond to converting all code without input from the original
authors.

As such, I am normally only happy to apply SPDX patches with an
ack from either the original author, or at least someone from the
company who holds the copyright.

I have expressed before that I actually consider these mostly
noise and so am not keen at all unless there is other work
being done on a particular driver.

So please split this up into at least separate patches
for each of the copyright holders, so they can provide an ACK
if they are happy with this change.

Some companies will for example want their legal departments to
do a review of whether SPDX is acceptable for their past contributions.
(lots won't care btw - but the potential is there).

+CC Linus Walleij as one of his files doesn't have a license...

A few other comments inline...

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7266.c             |  3 +--
>  drivers/iio/adc/ad7291.c             |  3 +--
>  drivers/iio/adc/ad7298.c             |  3 +--
>  drivers/iio/adc/ad7766.c             |  3 +--
>  drivers/iio/adc/ad7791.c             |  3 +--
>  drivers/iio/adc/ad7793.c             |  3 +--
>  drivers/iio/adc/ad7887.c             |  3 +--
>  drivers/iio/adc/ad7923.c             |  3 +--
>  drivers/iio/adc/ad799x.c             |  5 +----
>  drivers/iio/adc/ad_sigma_delta.c     |  3 +--
>  drivers/iio/adc/aspeed_adc.c         |  6 +-----
>  drivers/iio/adc/at91-sama5d2_adc.c   | 10 +---------
>  drivers/iio/adc/at91_adc.c           |  3 +--
>  drivers/iio/adc/axp20x_adc.c         |  5 +----
>  drivers/iio/adc/axp288_adc.c         | 13 +------------
>  drivers/iio/adc/bcm_iproc_adc.c      | 13 +------------
>  drivers/iio/adc/berlin2-adc.c        |  5 +----
>  drivers/iio/adc/cc10001_adc.c        |  6 +-----
>  drivers/iio/adc/cpcap-adc.c          | 10 +---------
>  drivers/iio/adc/da9150-gpadc.c       |  6 +-----
>  drivers/iio/adc/dln2-adc.c           |  5 +----
>  drivers/iio/adc/ep93xx_adc.c         |  5 +----
>  drivers/iio/adc/exynos_adc.c         | 11 +----------
>  drivers/iio/adc/fsl-imx25-gcq.c      |  5 +----
>  drivers/iio/adc/hi8435.c             |  6 +-----
>  drivers/iio/adc/hx711.c              |  6 +-----
>  drivers/iio/adc/imx7d_adc.c          |  6 +-----
>  drivers/iio/adc/ina2xx-adc.c         |  7 +------
>  drivers/iio/adc/lp8788_adc.c         |  5 +----
>  drivers/iio/adc/lpc18xx_adc.c        |  5 +----
>  drivers/iio/adc/lpc32xx_adc.c        | 15 +--------------
>  drivers/iio/adc/ltc2471.c            |  3 +--
>  drivers/iio/adc/ltc2485.c            |  5 +----
>  drivers/iio/adc/ltc2497.c            |  3 +--
>  drivers/iio/adc/max1027.c            |  5 +----
>  drivers/iio/adc/max1118.c            |  5 +----
>  drivers/iio/adc/max1363.c            |  5 +----
>  drivers/iio/adc/mcp320x.c            |  5 +----
>  drivers/iio/adc/mcp3422.c            |  6 +-----
>  drivers/iio/adc/men_z188_adc.c       |  5 +----
>  drivers/iio/adc/meson_saradc.c       |  5 +----
>  drivers/iio/adc/mt6577_auxadc.c      | 10 +---------
>  drivers/iio/adc/mxs-lradc-adc.c      | 11 +----------
>  drivers/iio/adc/nau7802.c            |  3 +--
>  drivers/iio/adc/palmas_gpadc.c       |  5 +----
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
>  drivers/iio/adc/qcom-spmi-iadc.c     | 10 +---------
>  drivers/iio/adc/qcom-spmi-vadc.c     | 10 +---------
>  drivers/iio/adc/rockchip_saradc.c    | 11 +----------
>  drivers/iio/adc/spear_adc.c          |  3 +--
>  drivers/iio/adc/stx104.c             | 10 +---------
>  drivers/iio/adc/sun4i-gpadc-iio.c    |  5 +----
>  drivers/iio/adc/ti-adc081c.c         |  5 +----
>  drivers/iio/adc/ti-adc0832.c         |  5 +----
>  drivers/iio/adc/ti-adc084s021.c      |  5 +----
>  drivers/iio/adc/ti-adc108s102.c      | 10 +---------
>  drivers/iio/adc/ti-adc12138.c        |  5 +----
>  drivers/iio/adc/ti-ads1015.c         |  5 +----
>  drivers/iio/adc/ti-ads8688.c         |  5 +----
>  drivers/iio/adc/ti-tlc4541.c         |  5 +----
>  drivers/iio/adc/ti_am335x_adc.c      | 10 +---------
>  drivers/iio/adc/twl4030-madc.c       | 16 +---------------
>  drivers/iio/adc/twl6030-gpadc.c      | 16 +---------------
>  drivers/iio/adc/vf610_adc.c          | 15 +--------------
>  drivers/iio/adc/viperboard_adc.c     |  7 +------
>  drivers/iio/adc/xilinx-xadc-core.c   |  3 +--
>  drivers/iio/adc/xilinx-xadc-events.c |  3 +--
>  drivers/iio/adc/xilinx-xadc.h        |  3 +--
>  68 files changed, 68 insertions(+), 361 deletions(-)
> 
...

> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index bdd7cba6f6b0..9bbcca9df401 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -1,20 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0+
Oh great, contradictory license text.   The first
part would normally imply GPL-2.0 and the second
is clearly GPL-2.0+

I'd leave this one be unless you can get input from the various
authors.

>  /*
>   * INA2XX Current and Power Monitors
>   *
>   * Copyright 2015 Baylibre SAS.
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Based on linux/drivers/iio/adc/ad7291.c
>   * Copyright 2010-2011 Analog Devices Inc.
>   *
>   * Based on linux/drivers/hwmon/ina2xx.c
>   * Copyright 2012 Lothar Felten <l-felten@ti.com>
>   *
> - * Licensed under the GPL-2 or later.
> - *
>   * IIO driver for INA219-220-226-230-231
>   *
>   * Configurable 7-bit I2C slave address from 0x40 to 0x4F


...

> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index a8d35aebee80..6d191ffc4c7e 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * iio/adc/max1363.c
>    * Copyright (C) 2008-2010 Jonathan Cameron
> @@ -9,10 +10,6 @@
>    * Copyright (C) 2000 Russell King
>    *
>    * Driver for max1363 and similar chips.
> -  *
> -  * This program is free software; you can redistribute it and/or modify
> -  * it under the terms of the GNU General Public License version 2 as
> -  * published by the Free Software Foundation.
>    */

This one's mine so in a separate patch you can add.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index c30c002f1fef..648136ed1f85 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0

Oh goody.  A file with out a license.  oops.
Thankfully an author we can easily get hold of!
Linus, what should it be?

>  /*
>   * Qualcomm PM8xxx PMIC XOADC driver
>   *

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
