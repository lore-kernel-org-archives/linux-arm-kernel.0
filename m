From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 28 Apr 2016 09:25:38 +0200
Subject: [PATCH v2 03/11] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <CACPK8Xdm_ZAyfUNbwEYrZuUZS4cP3YMkrkVbGNeiVmeFF6j3Cw@mail.gmail.com>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <4459295.XmBqACy0jk@diego>
 <CACPK8Xdm_ZAyfUNbwEYrZuUZS4cP3YMkrkVbGNeiVmeFF6j3Cw@mail.gmail.com>
Message-ID: <2297276.nzTbucM52b@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 28. April 2016, 16:20:04 schrieb Joel Stanley:
> On Wed, Apr 27, 2016 at 6:42 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Mittwoch, 27. April 2016, 18:01:00 schrieb Joel Stanley:
> >> > From what I remember exposing the clock controller as one block
> >> > (instead
> >> > of
> >> > declaring each clock individually in the dts) is still the preferred
> >> > way
> >> > but I don't think I can find Mike's mail from back then easily.
> >> 
> >> I can't picture how that would look. I took my lead from the moxart
> >> clock driver; is there a better example that I should follow?
> > 
> > qcom, samsung, rockchip, hisilicon, imx, ...
> 
> I had a look here, and they appear to be much more complex than I
> need. The qcom directory is 41000 lines of code! The moxart driver is
> similar to what we do, but as you mentioned it is not arranged how you
> want it.

I'm by no means authoritative ;-), but from what you describe below, clk-
asm9260.c or clk-efm32gg.c might be going in that direction of very simple 
clock-controllers.

Sorry about pointing to more complex drivers for bigger socs at first :-)


> > I guess the design would depend on the actual layout of your clock- /
> > system- controller - aka what else is contained there.
> 
> In the fourth generation parts, such as the ast2400, we have this layout:
> 
>     clock                rate
>  -----------------------------
>   clk_clkin          48000000
>      clk_hpll       384000000
>         clk_apb      48000000
> 
> clkin is the oscillator that may be running at 24, 25 or 48MHz. We can
> determine this from the strapping register.
> 
> The hpll divisor is controlled by strapping resistors, and indicated
> in the strapping register.
> 
> The apb is controlled by a register in the SCU, the Aspeed's
> bucket-of-bits for controlling various parts of the soc.

I remember that from working on Samsung s3c24xx socs, the system-controller 
area also worked as sort of catch-all :-) .

> 
> In our case we want don't need to adjust any clocks. We do want struct
> clk's so attached device drivers to know how fast they are being
> clocked. How do you see this laid out?

see drivers referenced above.
