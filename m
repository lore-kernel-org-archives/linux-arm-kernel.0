From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 8 Nov 2018 11:27:31 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add I2C-DVFS device
 node
In-Reply-To: <20181108102201.kuheale47tqygoe4@verge.net.au>
References: <1540071349-27483-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdV=ZinKOWZco9t4rGncYY5BqghXxGE6w9qCNW55UVSa+A@mail.gmail.com>
 <20181107123002.t6xg4m4vbq7cuapb@verge.net.au>
 <20181108102201.kuheale47tqygoe4@verge.net.au>
Message-ID: <CAMuHMdW=f77EafYXSzD3BiuMLirm+gjMnQZ7WzE0kX-TjXwkdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Nov 8, 2018 at 11:22 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Nov 07, 2018 at 01:30:10PM +0100, Simon Horman wrote:
> > On Mon, Nov 05, 2018 at 09:52:48AM +0100, Geert Uytterhoeven wrote:
> > > On Sat, Oct 20, 2018 at 11:35 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > >
> > > > This patch adds I2C-DVFS device node for the R8A77990 SoC.
> > > >
> > > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> > > > +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi

> > > >         };
> > > >
> > > >         cpus {
> > > > @@ -337,6 +338,22 @@
> > > >                         reg = <0 0xe6060000 0 0x508>;
> > > >                 };
> > > >
> > > > +               i2c_dvfs: i2c at e60b0000 {
> > > > +                       #address-cells = <1>;
> > > > +                       #size-cells = <0>;
> > > > +                       compatible = "renesas,iic-r8a77990",
> > >
> > > "renesas,iic-r8a77990" is not yet documented.
> >
> > Thanks, as per my comment below I wonder if as well as documenting
> > "renesas,iic-r8a77990" we also to teach the driver about it.
> >
> > >
> > > > +                                    "renesas,rcar-gen3-iic",
> > > > +                                    "renesas,rmobile-iic";
> > >
> > > Also, IIC on R-Car E3 does not have the automatic transmission registers.
> > > Does this affect claiming compatibility with the family-specific or generic
> > > compatible values?
> >
> > My cursory reading of the driver indicates that only register that is
> > used by it but documented as not existing on E3 is ICSTART (offset 0x70).
> >
> > It seems to me that we should confirm with Renesas that the register does
> > indeed not exist - as this patch comes from the BSP which implies it is
> > being used there. And if it does not exist we should try teaching the
> > driver not to use ICSTART via the "renesas,iic-r8a77990" compat string.
> > What do you think?
>
> Further examination by Wolfram Sang has shown that the code in question is
> only used on the r8a7740. I don't think there is any compatibility issue
> for r8a77990 when using the current driver.

"When using the current driver".
Do we want to claim compatibility with "renesas,rcar-gen3-iic" and/or
"renesas,rmobile-iic"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
