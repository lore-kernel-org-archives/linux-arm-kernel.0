From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 2 Aug 2018 16:07:22 +0200
Subject: [PATCH] ARM: shmobile: silk: Add DA9063 PMIC node
In-Reply-To: <42d09bc8-a883-c3af-b0d6-0087b6e2558e@gmail.com>
References: <20180730111817.5636-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXib8fz3c41RX-70eA5w4ThM6e02ybmX=N=xXR6=F80KA@mail.gmail.com>
 <42d09bc8-a883-c3af-b0d6-0087b6e2558e@gmail.com>
Message-ID: <CAMuHMdXSjLSsmU32tKo5tkS6+MipAXuVAUqkLYrXxmR07+eCEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Aug 2, 2018 at 3:56 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 08/01/2018 02:32 PM, Geert Uytterhoeven wrote:
> > On Mon, Jul 30, 2018 at 1:18 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> Add DA9063 PMIC node to the I2C bus.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >
> > Thanks for your patch!
> >
> > Oneline-summary prefix should be "ARM: dts: silk:".
>
> Right, fixed
>
> >> --- a/arch/arm/boot/dts/r8a7794-silk.dts
> >> +++ b/arch/arm/boot/dts/r8a7794-silk.dts
> >> @@ -403,6 +403,18 @@
> >>         pinctrl-names = "i2c-hdmi";
> >>
> >>         clock-frequency = <400000>;
> >> +
> >> +       pmic at 5a {
> >
> > Hmm, the da9063 is actually connected to two i2c buses: i2c1 (3.3v)
> > and i2c7 (1.8v).
> > On Koelsch, we describe the 1.8v connection, as that i2c bus
> > ("i2c_dvfs") is meant
> > for power control.
>
> On Koelsch, the pmic is sitting on i2c6 only. What am I missing ?

On Koelsch, i2c6 is wired to the da9063' 2-wire bus, and i2c1 is wired to
the da9063's HS (high-speed) 2-wire bus.

Wolfram: do you like i2c slaves connected to multiple buses?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
