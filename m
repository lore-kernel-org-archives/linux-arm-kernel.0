Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DB5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F21213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8pK8mP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F21213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j8SatQshBWZmG7extnF0dZNLTIjaVWeV5Hg/7Jblo2U=; b=l8pK8mP6G63+oy
	Nhw9wr7IZO60F8bYQhVCMPN5RSk3LTyPL+artJlWnN7SF8HMeWKqsa+V81MA8tACRaJeyZZwb4v6u
	jJSuPnCJlA0/9Sj+YmRghPNLIaJgvgThPil3XtWMKnfW5L7CuXGpCvRp5Aj+opacwNWJwvYeMzhrc
	56TbutG9WNYTDu1mtSo6wl8ea+QDIuiffTSNF8e4/oUP8sO5G9NLTycj5bKKYaR6ZW7cnmhJD+QNR
	NLurPCPnfYoZCGlqLcWOuOZzZtEqM1scYmD6ATHCGXb01mU8W6flt7XMuGa7Yhj0Vbu5MZRr6PmNR
	2hs1GxUFeK552Pr1plnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTpA-00067c-0M; Wed, 05 Dec 2018 09:50:32 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTp0-00064U-8p
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:50:29 +0000
Received: by mail-ed1-f66.google.com with SMTP id x30so16477254edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z/cbHVmOnR4ssoA0Bz+FRdDV0r+8venf015r/nDfnhU=;
 b=mFNJB0x9vb3ABepqd8933bTOJM4+fr3aGBM8v6PA6iUaLQOyvP1ZnIf4e9BIsZ9LzG
 0iM6D6pbqCdmc/fBZDdQ9IOFyaR/u+YsBJPmLW3HITU1XqNa9m1h2YJ+9o/cmxkGOxtD
 nhtpAdkfx4EgKGx68yvRV+kGXRT7c60Er9zulRYavEO+bSOMUMFcvyhs4nfiDB64xWI2
 s9O1CBSi5oh5VhgCTAWY17Y+OfktKafhIp96AOCsdKMvtK/YcwbRwT8sYV5FHYm8kSWF
 b0Uh3NQCcMp/B2c81aENblGMiZRKNgO1B26d5u7cbPXA90Y+x8xKjMsogRCTXOND0va9
 SYUA==
X-Gm-Message-State: AA+aEWZ0qwp3KBh96zIKuQCaWa7kdRZW/NWq0X4sP2uUmWhd5IXbu5dn
 pvEfpwpe6GEOjTim0VvMT3y1dhUiLKU=
X-Google-Smtp-Source: AFSGD/VnF5X7/kzBB+v0+Y7TBBjZpKdn+Vzh2J0IKNELC+6AnAv33fkypXPaC3lro0p2lDrGFO5row==
X-Received: by 2002:a17:906:30d5:: with SMTP id
 b21-v6mr18708195ejb.42.1544003410197; 
 Wed, 05 Dec 2018 01:50:10 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com.
 [209.85.221.52])
 by smtp.gmail.com with ESMTPSA id w24-v6sm3068981eja.71.2018.12.05.01.50.09
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 01:50:09 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id b14so5353591wru.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:50:09 -0800 (PST)
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr21994267wru.177.1544003408999; 
 Wed, 05 Dec 2018 01:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <20181205092444.29497-8-paul.kocialkowski@bootlin.com>
 <CAGb2v66JwZ_RkEdk6sz-0Z7EJx7ieG3zBT6yr-95X6guxUkKTg@mail.gmail.com>
 <edf44a24633ecaf59a7d5bea1f4acffdd0ae01a3.camel@bootlin.com>
In-Reply-To: <edf44a24633ecaf59a7d5bea1f4acffdd0ae01a3.camel@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 5 Dec 2018 17:49:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v67tgp_tD_Pkx1Qkc=d__saZUMwwmE44uCCeLgVM2HWmUQ@mail.gmail.com>
Message-ID: <CAGb2v67tgp_tD_Pkx1Qkc=d__saZUMwwmE44uCCeLgVM2HWmUQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] arm64: dts: allwinner: h5: Add system-control
 node with SRAM C1
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_015026_534322_6A22FCF3 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 5:48 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 2018-12-05 at 17:45 +0800, Chen-Yu Tsai wrote:
> > On Wed, Dec 5, 2018 at 5:25 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > Add the H5-specific system control node description to its device-tree
> > > with support for the SRAM C1 section, that will be used by the video
> > > codec node later on.
> > >
> > > The CPU-side SRAM address was obtained empirically while the size was
> > > taken from the documentation. They may not be entirely accurate.
> > >
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > index b41dc1aab67d..42bfb560b367 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > @@ -94,6 +94,28 @@
> > >         };
> > >
> > >         soc {
> > > +               system-control@1c00000 {
> > > +                       compatible = "allwinner,sun50i-h5-system-control";
> > > +                       reg = <0x01c00000 0x1000>;
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <1>;
> > > +                       ranges;
> > > +
> > > +                       sram_c1: sram@1d00000 {
> > > +                               compatible = "mmio-sram";
> > > +                               reg = <0x00018000 0x1c000>;
> >
> > 0x1d00000 or 0x18000?
>
> For the H5, I found the VE SRAM area to be mapped to 0x18000 on the CPU
> side (when testing with devmem), unlike the A64, H3 and others. I was
> rather surprised about this as well!

I'm actually referring to the node name that still says 1d00000.

ChenYu

>
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <1>;
> > > +                               ranges = <0 0x00018000 0x1c000>;
> >
> > Same here.
> >
> > > +
> > > +                               ve_sram: sram-section@0 {
> > > +                                       compatible = "allwinner,sun50i-h5-sram-c1",
> > > +                                                    "allwinner,sun4i-a10-sram-c1";
> > > +                                       reg = <0x000000 0x1c000>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > >                 mali: gpu@1e80000 {
> > >                         compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
> > >                         reg = <0x01e80000 0x30000>;
> > > --
> > > 2.19.2
>
> Cheers,
>
> Paul
>
> --
> Paul Kocialkowski, Bootlin (formerly Free Electrons)
> Embedded Linux and kernel engineering
> https://bootlin.com
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
