Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:16:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8949020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyGYzWw3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gwlITWmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8949020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U37kbplaAHX00U4qtmqvb7euIYlL855eY/KRHsootps=; b=dyGYzWw3QHCIjE
	co4GrrjuX+4ync1/kd8nEIgADjiXBfdWhh2QzXl8ISlva/qbOymeNkrPBJqXYapKt1slXD96U0sne
	dv5zpgem9D4Luh+PLkbeNJhg1rAKZu4yI2DoAz9n1s5lr0Z4Yw3uuinATTltd3edLEuT5TkbNisMy
	g42RM7eTtrOwVAUsmnAVr3mJ0oLg0suZmMHx1s17XbBHHyLHtRWwuqoXIZeMaCWkpGxr5KuyYNa5z
	EJPwGVT+9R5LqjlOVYoBLPur/A4BI3Y3iOyzVTo86cYD3kszD5i6R9FRvubpFDdU3DJeb2SsvA+kM
	dnONXZmvA8lhDRV2L/vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCFc-0005Fg-95; Fri, 07 Dec 2018 09:16:48 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCFK-0005F9-QC
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:16:33 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so3577980wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fclhWpJWTszcwfU4YUajRq4eqA2SoHkWc1KbhcPPrKo=;
 b=gwlITWmJjx2stbazuOJ8msEBQ4qdBf3HM//K/nUB/O4b3FPuKC1t8tSmCzi/U2MxH1
 Z6kFhSWCpME4OdVVctw0IemmIxbQQ2xVWe/pCXp12WRlnZM/M5UFAdiB75EzEPwrE6Pj
 dW57gcQcd3b+XIKUT5Au0qEtQeV/6q1goqHDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fclhWpJWTszcwfU4YUajRq4eqA2SoHkWc1KbhcPPrKo=;
 b=q92Ivq7DP4wgEH5F86yRqqHIFdwirb9tjhIjvPssvtqtRNwaGtorzZ7Og0nyOpm55W
 Z/MKG1SV3z+oQvwrR0B5VhioEunB4ZuFKu/f/E7BcpA1tWcEe/mKFTt+wbLvfkilHket
 YG+7hO78gf8XuD8lD3EWWltY4OkWSBwcN4z/GIpQ/DQceM3XB5boNoGBlpIS9bIlrOru
 sCUm7EFmgT/5NWYKpmN55euI/jOFe3xRzMfdyzuOE9lqhknhj1+jxkBLMHc3eef9sVHk
 rHJHvUvIQ7C8HrKNLJzSF49gFoR+KeTXfTWn8EXbXvtU3sy9EXjUVlb5DmbntGU6r6AO
 COaw==
X-Gm-Message-State: AA+aEWYjbHzaClZlWOq0MQ/VE32nztmHzlK0L8Nkc45fxN3WjQfpbkXf
 zVuOxj2u6+yxRKEAE9OldHWmjIDK4GK6cjT0EgMy/Q==
X-Google-Smtp-Source: AFSGD/X8KW7s+Wwp+tR/GM2mLriUXOf5B3fpqMKoBaC16G7/tomtQCdBaHg9Z2L8DBoMnpSJ80M9A02Se/HB4QHcJJ4=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr1570250wmf.115.1544174178482; 
 Fri, 07 Dec 2018 01:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com>
 <20181206153445.kqu2pep5orktr6yv@flea>
 <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com>
 <20181207074723.l3ykhqojfkd4y4ie@flea>
In-Reply-To: <20181207074723.l3ykhqojfkd4y4ie@flea>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 7 Dec 2018 10:16:07 +0100
Message-ID: <CAOf5uwk7xM=QmG_wzKYNEvudwDLh-ypLxPZZsDiUEjdbymCiUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_011631_334912_21E6A72C 
X-CRM114-Status: GOOD (  30.68  )
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
 devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Jagan Teki <jagan@amarulasolutions.com>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime

On Fri, Dec 7, 2018 at 8:47 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:07:59PM +0100, Michael Nazzareno Trimarchi wrote:
> > On Thu, Dec 6, 2018 at 4:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> > > > Allwinner A64 CSI controller has similar features as like in
> > > > H3, So add support for A64 via H3 fallback.
> > > >
> > > > Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> > > > the default clock 600MHz seems unable to drive the sensor(ov5640)
> > > > to capture the image.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v2:
> > > > - Use CSI_SCLK to 300MHz
> > > >
> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > index 384c417cb7a2..d7ab0006ebce 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > @@ -532,6 +532,12 @@
> > > >                       interrupt-controller;
> > > >                       #interrupt-cells = <3>;
> > > >
> > > > +                     csi_pins: csi-pins {
> > > > +                             pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
> > > > +                                    "PE7", "PE8", "PE9", "PE10", "PE11";
> > > > +                             function = "csi0";
> > > > +                     };
> > > > +
> > > >                       i2c0_pins: i2c0_pins {
> > > >                               pins = "PH0", "PH1";
> > > >                               function = "i2c0";
> > > > @@ -899,6 +905,23 @@
> > > >                       status = "disabled";
> > > >               };
> > > >
> > > > +             csi: csi@1cb0000 {
> > > > +                     compatible = "allwinner,sun50i-a64-csi",
> > > > +                                  "allwinner,sun8i-h3-csi";
> > > > +                     reg = <0x01cb0000 0x1000>;
> > > > +                     interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                     clocks = <&ccu CLK_BUS_CSI>,
> > > > +                              <&ccu CLK_CSI_SCLK>,
> > > > +                              <&ccu CLK_DRAM_CSI>;
> > > > +                     clock-names = "bus", "mod", "ram";
> > > > +                     resets = <&ccu RST_BUS_CSI>;
> > > > +                     pinctrl-names = "default";
> > > > +                     pinctrl-0 = <&csi_pins>;
> > > > +                     assigned-clocks = <&ccu CLK_CSI_SCLK>;
> > > > +                     assigned-clock-rates = <300000000>;
> > >
> > > That should be enforced in the driver.
> > >
> >
> > We are not really sure what is the best here. Our first idea was to
> > put in the board file and then Jagan
> > decide to put in dtsi. We don't have enough coverage of camera on this
> > CPU and I prefer to stay with this
> > minimal change that does not impact the driver.
>
> The thing is that:
>   - in this commit log, you're stating that it depends on the sensor,
>     which indicates that this would be a board level addition
>   - In another patch series, Jagan reported IIRC that it actually
>     depends on the resolution, so it doesn't belong in the DT at all
>   - And then, you don't even have any guarantee on the clock rate. The
>     sole guarantee you have is that when your driver will probe, the
>     rate will be close to those 300MHz. That's it. It might completely
>     change after the driver has probed, or be rounded to something
>     else entirely, who knows.

I'm not so interested in the story but it's clear what you ask but in
short having one
sensor up to 5M pixel we can be sure where the reason is but make it
more pratical.

We have a parent clock that is the peripheral clock on clock
tree that run at 600Mhz. With a clock divider of 0 the driver work but
the acquisition
as problem on quality. Now the same sensor seems to work when the
logic is clocked
as half of the speed. If I remind in the right way the divider can be
only possible so
you can get pclk / (n + 1) without reparent to a different input.
Now I don't find any nice documentation that state that 600Mhz
is not supported but anyway, you suggest to do the same that is done
in fimc driver so
set there the rate there and offcourse x platform change like:

#define A64_CSI_FREQUENCY 600

ret = clk_set_rate(csk_core_clk, A64_CSI_FREQUENCY);

>
> So really, putting it in the DT is nothing but a hack.
>

Michael


> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
