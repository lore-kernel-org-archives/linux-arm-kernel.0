From: steev@gentoo.org (Steev Klimaszewski)
Date: Sun, 19 Jul 2015 17:54:20 -0500
Subject: [PATCH] ARM: tegra: Fix nyan-big panel binding
In-Reply-To: <CAEUnVG6g-0iYexKPXjO167-O6Oay71QXnoVz1Hvs=U8tSOp5uw@mail.gmail.com>
References: <1437336913-12886-1-git-send-email-steev@gentoo.org>
 <CAEUnVG6g-0iYexKPXjO167-O6Oay71QXnoVz1Hvs=U8tSOp5uw@mail.gmail.com>
Message-ID: <1437346460.8225.6.camel@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-07-19 at 16:43 -0600, Dylan Reid wrote:
> On Sun, Jul 19, 2015 at 2:15 PM, Steev Klimaszewski <
> threeway at gmail.com> wrote:
> > The nyan-big Chromebook uses a 1920x1080 panel, not a 1366x768 
> > panel so correct
> > the binding.
> 
> This isn't incorrect, although it is not complete.  Nyan-big (Acer
> CB5-311) has _both_ a 1920x1080 and 1366x768 variant available.  They
> are referred to as the "Full HD" and "HD" models respectively.
> 

I wasn't aware they had the CB5-311 as a 1366x768 variant.  I guess we
need to split nyan-big up in mainline like ChromeOS does?  Should we do
the same thing that ChromeOS does and have each variant available?  I
noticed mine is actually a rev3_7 according to booting with a chromeos
kernel.  And for whatever reason, if I include both big and blaze in a
fit image using mainline, it always seems to pick the blaze dtb on my
big, so I'm guessing the compatible string is different as well.


> > 
> > Signed-off-by: Steev Klimaszewski <steev@gentoo.org>
> > ---
> >  arch/arm/boot/dts/tegra124-nyan-big.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts 
> > b/arch/arm/boot/dts/tegra124-nyan-big.dts
> > index 2d21253..30d4495 100644
> > --- a/arch/arm/boot/dts/tegra124-nyan-big.dts
> > +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
> > @@ -9,7 +9,7 @@
> >         compatible = "google,nyan-big", "nvidia,tegra124";
> > 
> >         panel: panel {
> > -               compatible = "auo,b133xtn01";
> > +               compatible = "auo,b133htn01";
> > 
> >                 backlight = <&backlight>;
> >                 ddc-i2c-bus = <&dpaux>;
> > --
> > 2.4.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux
> > -tegra" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
