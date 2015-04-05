From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 05 Apr 2015 23:06:20 +0300
Subject: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
In-Reply-To: <CAMuHMdWsc=2QvKfpYmN=M6As_KWENW2nhSqa8ajkZrQFe+dCPw@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <34835209.cQQp4PEGGk@avalon>
 <CAMuHMdWsc=2QvKfpYmN=M6As_KWENW2nhSqa8ajkZrQFe+dCPw@mail.gmail.com>
Message-ID: <2722685.XFRaAHH9GQ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Sunday 05 April 2015 11:00:56 Geert Uytterhoeven wrote:
> On Sat, Apr 4, 2015 at 2:46 PM, Laurent Pinchart wrote:
> >> +     for (i = 0; i < dev->ngpios; i++)
> >> +             gpio_request_one(dev->gpios[i].gpio, dev->gpios[i].flags,
> >> +                              pdev->name);
> > 
> > Aren't GPIO numbers dynamic too in DT-based systems ? Beside, shouldn't it
> > be
>
> Apparently not, as the old legacy number still works, and it doesn't work
> without.

I think we're just lucky there that the SoC main GPIO controller gets 
registered first and starts counting GPIOs with a zero offset.
 
> > the responsibility of the drievr to request the GPIOs it needs ?
> 
> As far as I understand it, on Armadillo this is used more for platform
> configuration than for device configuration, as it affects multiple devices
> (the comment says DBGMD/LCDC0/FSIA MUX).
> 
> I guess I could use a "gpio-hog" subnode in DT instead, but then we're
> already implementing the conversion to DT ;-)

But that's the goal :-) I'd rather move GPIO and pinctrl to DT directly as we 
already have the infrastructure to do so.

-- 
Regards,

Laurent Pinchart
