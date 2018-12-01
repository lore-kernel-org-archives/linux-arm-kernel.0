Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC7C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:58:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13F820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fLi6AaGD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="noVHLMwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13F820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Tr/QqAEMHBg/RTCK/o2OgnV8/cHhNqWWfr92DArXFc=; b=fLi6AaGDe3vg3a
	umIWsCgVsGjI3d1+dt2RthiiYd/fbCq2XFFHRkyW1bufRPdagg3fwblI/gn1nQvHJ5T8JGSGmlvAu
	jfJOxnCAKCDwbqyA/9tBDtgkS5wuJ+Q2EPBagciUYnmjkPvKGmqsFgyarW7oUyg0PpM9mR7Z/ymSE
	3DbtVxJlxaDy9elWh2EVP9UcuWfpiiIRg3rUXrakFnpkhHmUaeZOlvi8tAP6W27Idj5GdXezdpdfM
	j1B8ltG7zWIC+rh7XPP7E5eHloBhIVaYuByys0gn/DDfZr2L7pOgWRLGCKC80izW9xgsGJdPlQFAi
	4IRvoa2izGytexN8Pa7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT7ev-000862-1I; Sat, 01 Dec 2018 15:58:21 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT7eo-000811-GM
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 15:58:17 +0000
Received: by mail-it1-x143.google.com with SMTP id p197so2833981itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SkzcyiQiyJc9yxi/rIgf5y1xamgSfBuGe9V8W/ucOp0=;
 b=noVHLMwiHOiQ2kfsFTBS/Lf8upkPjXFqZfxKdRSi8ikUCRqQ8z7nxfNy2SjZZP0rZm
 CGcJ8/T83irYXUIaFoj4BqAoI8LynJuC7aFql9NQwoPJmWsq5CaP7ke0tyS7Zxw/3VzY
 zF+mA3tUFFeelWyKewpPJKA9WTv9UsFe24QMzS1qQ7ICWBvk/LXEhgdoxh6+qRJ/n2E8
 UAikWCQxqUoWESg5n1hfOS7kdP1KBsv3W9nrWDBlXopny8Si2VZhH8JW+ZgiynGc02CY
 tUOtucqenaMwUZuaDNb/fUhKr47d/EQt/p0rSxSROoGgyHIi7i+UK0WOvaGv3xK2j9dD
 vK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SkzcyiQiyJc9yxi/rIgf5y1xamgSfBuGe9V8W/ucOp0=;
 b=VauZzfqs96DoMqh4WKV+6wX38rZ/lsQVywFXxOD7kd9ulT9+Tik3+obzPnmVZk/3dL
 0nZcJKYaDDrUKbVvMXozK04INvlX04p+oZu3CZ+nboLzssI4ApE+XSc3P16VR3SUuB3H
 4QYUfqMddihA2B24+iRN2JAV6M/DmNcOIt/pu66qziIaE1K0khK3RTeUzMRRtJynU8Bu
 3osaeOtMNMYFRCpmpZ7m8bXihIUAoHJ4atUSz6AgKWuuqhUmeoUkbxGni+e1Q7NNuOlJ
 YrdTdoPluysG9vA7gb2iKdvvNTD6tzLwwp9b1gJlRoLPK1ACbrxLmpbukMUNKOjPWePq
 Cq2Q==
X-Gm-Message-State: AA+aEWaZ19xcsZu+Kd8vm/WCezl9Adfj3mlzv5fDqoFSG/IuycE0El0P
 b4OUWuPht32YzYJLjDkOt8E7SFdfFvG1ggg2aOonWA==
X-Google-Smtp-Source: AFSGD/U/lUK8U3Qi/P+itWYdkfNNRaOtPzf4eybzx9ds6V0pnyN6xD6oDo+mjywtGxLhtZ3M8vFAf2VdbFxVVYhxmV4=
X-Received: by 2002:a24:a0cb:: with SMTP id o194mr2394034ite.115.1543679883676; 
 Sat, 01 Dec 2018 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
 <CAJKOXPeY7BENW=LdotGQtL25-7BZABZw=awnY5h2h52q+nN8+g@mail.gmail.com>
In-Reply-To: <CAJKOXPeY7BENW=LdotGQtL25-7BZABZw=awnY5h2h52q+nN8+g@mail.gmail.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 1 Dec 2018 13:57:51 -0200
Message-ID: <CAHd-oW5wqfo8Nszp54X=ndxBQ6Kmbe+fk6Hk6GX6==Huerdwtw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_075814_543993_57EAC6E8 
X-CRM114-Status: GOOD (  23.97  )
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
 Michal Simek <michal.simek@xilinx.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, kernel-usp@googlegroups.com,
 Lars-Peter Clausen <lars@metafoo.de>, linux-rockchip@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-iio@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>,
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
 Carlo Caione <carlo@caione.org>, Eugen Hristev <eugen.hristev@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 5:37 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 28 Nov 2018 at 18:53, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >
> > From: Lucas Santos <ilucas.ms@gmail.com>
> >
> > This patch removes all license boilerplate texts from the .c and .h
> > files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> > identifiers.
> >
> > Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  drivers/iio/adc/ad7266.c             |  3 +--
> >  drivers/iio/adc/ad7291.c             |  3 +--
> >  drivers/iio/adc/ad7298.c             |  3 +--
> >  drivers/iio/adc/ad7766.c             |  3 +--
> >  drivers/iio/adc/ad7791.c             |  3 +--
> >  drivers/iio/adc/ad7793.c             |  3 +--
> >  drivers/iio/adc/ad7887.c             |  3 +--
> >  drivers/iio/adc/ad7923.c             |  3 +--
> >  drivers/iio/adc/ad799x.c             |  5 +----
> >  drivers/iio/adc/ad_sigma_delta.c     |  3 +--
> >  drivers/iio/adc/aspeed_adc.c         |  6 +-----
> >  drivers/iio/adc/at91-sama5d2_adc.c   | 10 +---------
> >  drivers/iio/adc/at91_adc.c           |  3 +--
> >  drivers/iio/adc/axp20x_adc.c         |  5 +----
> >  drivers/iio/adc/axp288_adc.c         | 13 +------------
> >  drivers/iio/adc/bcm_iproc_adc.c      | 13 +------------
> >  drivers/iio/adc/berlin2-adc.c        |  5 +----
> >  drivers/iio/adc/cc10001_adc.c        |  6 +-----
> >  drivers/iio/adc/cpcap-adc.c          | 10 +---------
> >  drivers/iio/adc/da9150-gpadc.c       |  6 +-----
> >  drivers/iio/adc/dln2-adc.c           |  5 +----
> >  drivers/iio/adc/ep93xx_adc.c         |  5 +----
> >  drivers/iio/adc/exynos_adc.c         | 11 +----------
> >  drivers/iio/adc/fsl-imx25-gcq.c      |  5 +----
> >  drivers/iio/adc/hi8435.c             |  6 +-----
> >  drivers/iio/adc/hx711.c              |  6 +-----
> >  drivers/iio/adc/imx7d_adc.c          |  6 +-----
> >  drivers/iio/adc/ina2xx-adc.c         |  7 +------
> >  drivers/iio/adc/lp8788_adc.c         |  5 +----
> >  drivers/iio/adc/lpc18xx_adc.c        |  5 +----
> >  drivers/iio/adc/lpc32xx_adc.c        | 15 +--------------
> >  drivers/iio/adc/ltc2471.c            |  3 +--
> >  drivers/iio/adc/ltc2485.c            |  5 +----
> >  drivers/iio/adc/ltc2497.c            |  3 +--
> >  drivers/iio/adc/max1027.c            |  5 +----
> >  drivers/iio/adc/max1118.c            |  5 +----
> >  drivers/iio/adc/max1363.c            |  5 +----
> >  drivers/iio/adc/mcp320x.c            |  5 +----
> >  drivers/iio/adc/mcp3422.c            |  6 +-----
> >  drivers/iio/adc/men_z188_adc.c       |  5 +----
> >  drivers/iio/adc/meson_saradc.c       |  5 +----
> >  drivers/iio/adc/mt6577_auxadc.c      | 10 +---------
> >  drivers/iio/adc/mxs-lradc-adc.c      | 11 +----------
> >  drivers/iio/adc/nau7802.c            |  3 +--
> >  drivers/iio/adc/palmas_gpadc.c       |  5 +----
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
> >  drivers/iio/adc/qcom-spmi-iadc.c     | 10 +---------
> >  drivers/iio/adc/qcom-spmi-vadc.c     | 10 +---------
> >  drivers/iio/adc/rockchip_saradc.c    | 11 +----------
> >  drivers/iio/adc/spear_adc.c          |  3 +--
> >  drivers/iio/adc/stx104.c             | 10 +---------
> >  drivers/iio/adc/sun4i-gpadc-iio.c    |  5 +----
> >  drivers/iio/adc/ti-adc081c.c         |  5 +----
> >  drivers/iio/adc/ti-adc0832.c         |  5 +----
> >  drivers/iio/adc/ti-adc084s021.c      |  5 +----
> >  drivers/iio/adc/ti-adc108s102.c      | 10 +---------
> >  drivers/iio/adc/ti-adc12138.c        |  5 +----
> >  drivers/iio/adc/ti-ads1015.c         |  5 +----
> >  drivers/iio/adc/ti-ads8688.c         |  5 +----
> >  drivers/iio/adc/ti-tlc4541.c         |  5 +----
> >  drivers/iio/adc/ti_am335x_adc.c      | 10 +---------
> >  drivers/iio/adc/twl4030-madc.c       | 16 +---------------
> >  drivers/iio/adc/twl6030-gpadc.c      | 16 +---------------
> >  drivers/iio/adc/vf610_adc.c          | 15 +--------------
> >  drivers/iio/adc/viperboard_adc.c     |  7 +------
> >  drivers/iio/adc/xilinx-xadc-core.c   |  3 +--
> >  drivers/iio/adc/xilinx-xadc-events.c |  3 +--
> >  drivers/iio/adc/xilinx-xadc.h        |  3 +--
> >  68 files changed, 68 insertions(+), 361 deletions(-)
> >
>
> (...)
>
> > diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> > index 5036c392cb20..8f614c84b643 100644
> > --- a/drivers/iio/adc/ep93xx_adc.c
> > +++ b/drivers/iio/adc/ep93xx_adc.c
> > @@ -1,12 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Driver for ADC module on the Cirrus Logic EP93xx series of SoCs
> >   *
> >   * Copyright (C) 2015 Alexander Sverdlin
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> >   * The driver uses polling to get the conversion status. According to EP93xx
> >   * datasheets, reading ADCResult register starts the conversion, but user is also
> >   * responsible for ensuring that delay between adjacent conversion triggers is
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > index f10443f92e4c..9f9c186e2135 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   *  exynos_adc.c - Support for ADC in EXYNOS SoCs
> >   *
> > @@ -5,16 +6,6 @@
> >   *
> >   *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> >   *
> > - *  This program is free software; you can redistribute it and/or modify
> > - *  it under the terms of the GNU General Public License as published by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> >   *  You should have received a copy of the GNU General Public License
> >   *  along with this program; if not, write to the Free Software
> >   *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>
> The paragraph about writing to FSF should also go away, especially it
> is discouraged at first place (see checkpatch).
>

Nice catch! Thanks,
Matheus

> Best regards,
> Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
