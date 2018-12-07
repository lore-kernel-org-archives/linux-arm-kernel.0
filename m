Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B0C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:37:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D64A20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G4Ua/E15";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f51UR0bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D64A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d7le5k+PAMIoPG+rSEyE7BOZ7NjurnB9oFGXNDRaPIg=; b=G4Ua/E15BWFwZK
	ZGNX3UlkVpSAGaum5EydnEsmXWj7BSnZ0EziiofBqOEhKoKh1WxW2jxMmDf1DlRP578jp2LI4hDuK
	w/N167hPU5hbRduNJ0LHhhkcusXxcZG2C7gyfs36XWK4az3PJl28HxJZ0mOgf0ApBsXlaYhaCgQWa
	CIJu73Td+K7efOqHQM+Fx4K+IKYm9o0VR9vsGrMKk3IOMWImTzN3FXRA1ECDZhGldqG//UKJvWvGK
	itJWwtcC87j4cUw7CXY7QKwRKpy6MNGfji3Mpa37tnfdNz4eD9bkaJ65fjL4+Gvd+QaK3pFK5ucx3
	H/5Rd3v7oUr43TuTAhbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJ7f-0001ot-MF; Fri, 07 Dec 2018 16:37:03 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJ7b-0001o3-KM
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:37:01 +0000
Received: by mail-it1-x144.google.com with SMTP id a6so7938999itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 08:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h8+IrCx5L4YsuFWt/qdvOgxN1J5jo/dTUc6DKcFQ6JU=;
 b=f51UR0bSfA9B/9f20QORuqwq0mkpqM7wWOeHhHdA980bowVLvjm2rYOeCYcjQ6kiGM
 2FGGBySgfAmn92EQz+PETtsfXrJSCQt7bDtTw8VuH9pkck6Zyvtu0JJ4oEEHhTUsQ4qF
 fpsCh5q30kCvmweXRfraUPtgxes87/HGRcBUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h8+IrCx5L4YsuFWt/qdvOgxN1J5jo/dTUc6DKcFQ6JU=;
 b=IOAxsErsnRjbktmMFkiKj4XKnAW0Nb+Rt07DVnDF2lJfof/u6MWZYMjMxIU79cxBSy
 dD4TD98ItO+6wKhBKxAnSsuTR9eTNBr1K0oRnzrh1UPe5G4APBXaMZtiufW5WcM1Wr2l
 Y9l9S46XSwhvJ6v3VrURsdquKE5Kyi7/p2kgd/fPeIxCW6SP3uH2lLDbbZxG9/4ITYkm
 fEo/wj4fbKBtonqeQfEwV8gjolbuRtkRk851W/jVr+gxdzEUs5Or3vm6MtIjDTfQdUEz
 ruicfWvfxyUE2czq2MfO/3Yzk99sIUD1yXPKBwnTf07i7abGPrv8wm5PUQpEpCdyrRL1
 GXCw==
X-Gm-Message-State: AA+aEWbmZK6VF3+yfW5rcBrBQPxQYqgvtCG0I8ucj2C2X7OCbPxtbx2j
 l4wyTY590lbx6qOuCfbDtaIT5w2m9AHj6VsT6THkHg==
X-Google-Smtp-Source: AFSGD/XYiW04SSisRb1AgknR6DzHmPrnuAu1ncG/mDYb/93ifLG80ToxfCTBrGg7yjnHGiA7sxam9RKpS1BmMhMD5IY=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr2742857ity.173.1544200608302; 
 Fri, 07 Dec 2018 08:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com>
 <20181206153445.kqu2pep5orktr6yv@flea>
 <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com>
 <20181207074723.l3ykhqojfkd4y4ie@flea>
In-Reply-To: <20181207074723.l3ykhqojfkd4y4ie@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 7 Dec 2018 22:06:34 +0530
Message-ID: <CAMty3ZDTGen-QnQ=urtaO2H8UxEX=ANH20rL-xFzGhtYWjHJ=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_083700_133775_B488866D 
X-CRM114-Status: GOOD (  25.45  )
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
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 1:17 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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

Let's to be clear.

- with default clock(600MHz) the sensor get probed but image capture
has an issue.
- with 300MHz the image capture working with 320x240@30, 640x480@30,
640x480@60, 1280x720@30 with UYVY8_2X8 and YUYV8_2X8 formats but
1080p@30 seems broken (the same I have mentioned in another mail)
- since all this is verified on ov5640, I have mentioned the same
thing on commit message for future reference.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
