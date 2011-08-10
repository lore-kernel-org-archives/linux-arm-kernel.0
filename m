From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 10 Aug 2011 11:39:20 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
In-Reply-To: <CAMPhdO-PH2M-VyzqOHnUo7j54Ok8D=xuh1cX2F+KVL4fCkFKnw@mail.gmail.com>
Message-ID: <1312972760.78921.YahooMailClassic@web29001.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> > Not sure I understand. In the case of GPIO23 (SSPSCLK)
> I switched the direction from output to input; none of the
> defines in mfp-pxa27x.h were applicable so I used MFP_CFG_IN
> directly. AFAIK the four wire GPIOs (23-26) aren't used
> anyway, so that change was really just for documentation.
> 
> Please check arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> 
> If GPIO23 needs to be configured as input when acting as
> SSP1_SCLK,
> please modify that file instead, it's a fix to other
> platforms as well.
> 
> So the general guideline here is: to use the macros in
> mfp-pxa27x.h
> as much as possible, since those are the standard
> definitions across
> all pxa27x boards.
> 
> MFP_CFG_*() are solely used for internal purposes, please
> do not use
> them directly.

OK, will do.

> > AFAIK Linux doesn't provide an SPI slave side API. So
> I had little option other than to drive SSP directly.
> 
> Are you implying that the hx4700 is acting as a SPI slave?

Yes.

> My original
> understanding is hx4700 is communicating with an external
> touchpad
> controller through SPI? If hx4700 is acting as a SPI slave,
> then it's true
> there is no existing framework for that yet.

That's correct; the NavPoint touchpad controller is the SPI master, Linux is the SPI slave.

Regards,
Paul
