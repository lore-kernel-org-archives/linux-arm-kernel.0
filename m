Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:57:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B9A2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KoN8iPPI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sLqH76PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B9A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dsrQGijHLblYvM/n2s9V+X9nGSehHOUhoEw4Hgt5fEo=; b=KoN8iPPIYsCjA6
	SAeOIwiGfiIZPswUWWK4r8yoSCwMVIoMkUWPdURC7HyA99qUuW23JDfnQTlq1IbzDhux97ogc9Wk9
	eRjkc6vDHXMUF2i1oO2jOGKGgucrJpQmZuGTMXjojYTPglGGRzmSgMPW20B+v/T6FNDKOvDal+Pxy
	LilljmwrCmJk5XIXtMyu9m/eAOddHkHca3yulJxyCM7/gCN5GhpkTE92LqiLvjkK/t868MmZR0/kq
	NgQA8fdfXTuWV29sH/SkzCShUaiPMKJMHU1E41ooU0Addovxm5waZjm4+cT4GbGjGdhAcQNU3c41M
	nN8gIbrWBsS/OMLIMONQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT7dx-0007g8-Em; Sat, 01 Dec 2018 15:57:21 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT7du-0007er-Ct
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 15:57:20 +0000
Received: by mail-it1-x143.google.com with SMTP id b5so2808974iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41+3VCJ4ZSFEMCnJ05n6tH7/QnAaCqx2XlEKnbLFX9A=;
 b=sLqH76PDwUa0k9fHHpWj/Y0t0tx81YBCvJVNEPx3Jnk1LRrmvJuqNOYpTUpVmnEsCz
 9bz4xqL9Ge31Fpda2Rp0mYKVIUiShHhUduZeduI0bgXDKpuGKbO6mxVxVvdaeLcNHPpy
 HMuIQcXsmjhTlnfrl6GGgw3k+aJA8WzN088sZ+14NfEslyhvTepZH2qVOmWwIl4mafEF
 f86waR3j3gD3i+TFYoeRT7Ti0/25NTxm2NtU3J2LujZ1UyQySSXk899ufh0Iz7OPZRhB
 Y8tFKkWH8Ft5XPM/eUZXEuuIGV9DFQAinviIkKWe+ZxgOrVe6SMPOCE2dzGA6tml5PQU
 DlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41+3VCJ4ZSFEMCnJ05n6tH7/QnAaCqx2XlEKnbLFX9A=;
 b=slJXP4wUaOPmarM0Oy9JVEi+IjC/h5FdSkvVG6+OCWP62kVEsmhwy9y+diegdMY3jO
 G5arIBub4hz4+PnQ9kFjvsZ3NS+YuRimEow96oC42Mnh3qBIEhnvb+EAErZyuySZKfIr
 0HFTTXZD053J7OyldrK/xsKlA3B1FL2bFgtp2BWEDG1zDqFeNlTQREpmQSTLJhJdtprx
 58SQXSfVnwsE881BgrGSIWTUf4MJX5rM4KzNyb35zx8Y0qglP4Y+/3+zknpGAfjHbxwH
 SnSO7+jLPHDYwAaiXbtuLC4cN9vQacgOhw+48cyd//KxuIs44kttQ8Oz0+/tuVx4gnid
 CcqA==
X-Gm-Message-State: AA+aEWZKIG3zL3a7/6ny+IFDHm0Ci+kj5mowN2uN5UGESFwCwsFPwWhL
 gRkejDu6BOFCMYtt0ZGWfzMusMxFFCLfs+XRZFxz0DJofs8=
X-Google-Smtp-Source: AFSGD/WOULCqe6a03vpxSEF3Gl5gt19ghssY/tXc0uwSVsuQ5sHpKh4touYOF1/N10i9+Og6jKn8XjORba/X7me+cvI=
X-Received: by 2002:a24:22c6:: with SMTP id o189mr2376954ito.86.1543679827575; 
 Sat, 01 Dec 2018 07:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
 <20181128192901.GG8952@piout.net>
In-Reply-To: <20181128192901.GG8952@piout.net>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 1 Dec 2018 13:56:55 -0200
Message-ID: <CAHd-oW4umU7-BnLHYsokA3JhNbQ0TRU+WM2U0HCgqSz0Ebk3Xw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_075718_438108_3A0C2973 
X-CRM114-Status: GOOD (  25.02  )
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
Cc: Milo Kim <milo.kim@ti.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-aspeed@lists.ozlabs.org, Maxime Ripard <maxime.ripard@bootlin.com>,
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
 Carlo Caione <carlo@caione.org>, Eugen Hristev <eugen.hristev@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks for the review! I will fix those places.

Matheus

On Wed, Nov 28, 2018 at 5:29 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 28/11/2018 15:53:12-0200, Matheus Tavares wrote:
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
> You forgot to remove some of the boilerplate here.
>
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 36b59d8957fb..894d49843854 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -1,13 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * HX711: analog to digital converter for weight sensor module
> >   *
> >   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> >   * This program is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>
> and here
>
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 729becb2d3d9..f5299c9bdbde 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -1,12 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
> >   *
> >   * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> >   * You should have received a copy of the GNU General Public License
> >   * along with this program. If not, see <http://www.gnu.org/licenses/>.
>
> and here.
>
> >   */
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20181128192901.GG8952%40piout.net.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
