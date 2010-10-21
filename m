From: jgq516@gmail.com (xiao jiang)
Date: Thu, 21 Oct 2010 14:18:35 +0800
Subject: [PATCH v2 1/1] mx35pdk: add debug board support
In-Reply-To: <20101021060743.GB13930@jasper.tkos.co.il>
References: <1287567283-19488-1-git-send-email-jgq516@gmail.com>
	<20101020100553.GD2691@jasper.tkos.co.il>
	<AANLkTim4CsbV+jSbFGN+SEDQrwfCPhPKPB9zjd=XDVEp@mail.gmail.com>
	<AANLkTimxOOxWD1tcneevcxcHzHMQLwmpC75krYLfCAut@mail.gmail.com>
	<20101021060743.GB13930@jasper.tkos.co.il>
Message-ID: <AANLkTikK7Pf4xV9c4dcX-5OMX=NggvNRv=rsSAfaUAfO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/21 Baruch Siach <baruch@tkos.co.il>

> Hi xiao,
>
> On Thu, Oct 21, 2010 at 10:08:02AM +0800, xiao jiang wrote:
> > 2010/10/21 xiao jiang <jgq516@gmail.com>
> > > 2010/10/20 Baruch Siach <baruch@tkos.co.il>
> > >> On Wed, Oct 20, 2010 at 05:34:43PM +0800, jgq516 at gmail.com wrote:
> > >> > From: Xiao Jiang <jgq516@gmail.com>
> > >> >
> > >> > Enable debug board support for mx35pdk. As suggested
> > >> > by Fabio, add MXC_DEBUG_BOARD config and redefinition
> > >> > EXPIO_PARENT_INT.
> > >> >
> > >> > Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> > >> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > >> > ---
> > >> >  arch/arm/mach-mx3/Kconfig         |    1 +
> > >> >  arch/arm/mach-mx3/mach-mx35_3ds.c |    8 ++++++++
> > >> >  2 files changed, 9 insertions(+), 0 deletions(-)
> > >> >
> > >> > diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> > >> > index 85beece..cdf6ac5 100644
> > >> > --- a/arch/arm/mach-mx3/Kconfig
> > >> > +++ b/arch/arm/mach-mx3/Kconfig
> > >>
> > >> [snip]
> > >>
> > >> > @@ -95,6 +99,10 @@ static void __init mxc_board_init(void)
> > >> >       imx35_add_imx_uart0(&uart_pdata);
> > >> >
> > >> >       mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
> > >> > +
> > >> > +     if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
> > >> > +             pr_warn("Init of the debugboard failed, all "
> > >> > +                     "devices on the board are unusable.\n");
> > >>                             ^^^^^
> > >> You probably mean debugboard here. I'd change the wording.
> > >>
> > >> There are some devices in the debug board, such as lan9217 ethernet.
> If
> > > mxc_expio_init failed,
> > > then the lan9217 can't be use.
>
> Of course. But this does not make devices on the main board unusable, isn't
> it? The user might think that his whole system is unusable because of this
> init failure.
>
> Ok, no relation with main board, to avoid confuse, maybe "all devices on
the *debug* board are unusable" is more make sense, is it ok?

Thanks,
Xiao Jiang

> > > BTW: In mach-mx5/board-mx51_3ds.c and mach-mx31_3ds.c, the warn
> messages
> > > are same.
> > > if (mxc_expio_init(MX51_CS5_BASE_ADDR,
> > > EXPIO_PARENT_INT))
> > >
> > >                  printk(KERN_WARNING "Init of the debugboard failed,
> all "
> > >
> > >                                      "devices on the board are
> > > unusable.\n");
> > >
> > > Ooo, I pressed  the keyboard neglectfully[?], and you can see below
> > sentence in mach-mx31_3ds.c.
> > if (!mxc_expio_init(CS5_BASE_ADDR, EXPIO_PARENT_INT))
> >          printk(KERN_WARNING "Init of the debugboard failed, all "
> >                "devices on the board are unusable.\n");
>
> Then this wording should also change there. Adding Jason Wang to Cc.
>
> baruch
>
> > Thanks,
> > Xiao Jiang
>
> --
>                                                      ~. .~   Tk Open
> Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101021/a17d2d10/attachment.html>
