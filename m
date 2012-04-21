From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 21 Apr 2012 10:17:58 +0200
Subject: [RFC PATCH 00/10 V3] MXS: Add i.MX28 USB Host driver
In-Reply-To: <CAL411-oN3RWQXduWVGrQ+FMEpiR+ZhJ1v-rmFnYwj3-0sJQVKw@mail.gmail.com>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <20120420094805.GS20478@pengutronix.de>
 <CAL411-onyB8SJEBoJ2XK=wyHKR0C7SyJtCsoJCDZGatP8HmYZg@mail.gmail.com>
 <201204201444.49184.marex@denx.de>
 <20120420132647.GQ3852@pengutronix.de>
 <20120420163626.GL14876@pengutronix.de>
 <CAL411-oN3RWQXduWVGrQ+FMEpiR+ZhJ1v-rmFnYwj3-0sJQVKw@mail.gmail.com>
Message-ID: <20120421081758.GT20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 03:42:46PM +0800, Peter Chen wrote:
> >
> Your guys all consider ci13xxx is better than fsl_udc_core.c, can you
> list some reasons?
> Or just because it can compatible with your prefer OTG structure (like
> msm_otg.c)?
> From my point, I also admit OTG structure like msm_otg.c is good one
> and we can
> follow it at i.mx USB structure.
> 
> >
> > We also made some tests with some gadget devices. IMHO we had troubles
> > with gadget_zero and testusb on the fsl_udc_core.c. I think the testusb
> > results should help to decide which is the most stable implementation.
> >
> ci13xxx one is no problem? Have you checked why it failed at fsl_udc_core.c?
> 
> >
> > >
> > > > Also, ci13xxx and fsl_usb_core is duplicated stuff, correct?
> > >
> > > Yes.
> > >
> > > >
> > > > > I will check with IC guys to see if i.mx's controller is compatible
> > > > > with CI13412.
> > > > > If fsl's compatible with CI13412, then mxs can try to use ci13xxx_udc.c to
> > > > > see if there are any problems, If no problems with kinds of testing,
> > > > > we can switch all i.mx SoC to ci13xxx_udc.c.
> > > >
> > > > Sascha, did you need to patch this ci13xxx somehow to get it running on MXS ? Or
> > > > what was it that said he got it somehow running?
> > >
> > > It basically works out of the box. I think we have some patches for this
> > > driver, maybe michael can comment on this.
> >
> > Yes, i have some smaller bugfix patches hanging around. I will send them
> > to the linux-usb mailinglist until the next week. Additionaly i have
> > some platform gluecode and a platform-support patch for the driver but you
> > probably have the same.
> >
> > The ci13xxx_udc_driver has a flags element, which has to be set
> > appropriate to the used platform. On the mx23 for example we only were
> > able to get all testusb results correct, when the option
> > CI13XXX_DISABLE_STREAMING was set. In the OTG case the option
> > CI13XXX_REGS_SHARED is mandatory.
> 
> I have checked with IC guys, but they doesn't know something like
> "CI13412" stands
> for.
> Yes, current many ARM SoC use chipidea SoC,  besides,
> - ci13xxx_udc
> - fsl_usb_core
> - langwell_udc
> marvell and Tegra are also use this. I have no maintain experiences on
> abstract one IP driver
> from kinds of SoC venders, if one SoC platform finds problem at
> ci13xxx_udc core,
> and submit the patch, it needs to verify at all SoC platforms, it may
> increase difficulty
> for review process and maintenance.

It's been some time since I last heard this argument...

Think about it, with this argument you could start writing your own
kernel, because how can you be sure that a change to the Linux Kernel
will work on your system?
You get much more maintainability from several SoCs sharing the same
code and more people fixing the bugs in your driver. Yes drivers do
occasionally break because a certain change is incompatible to a
particular SoC, but the advantages of sharing code outweigh this
multiple times.
(I didn't make this up myself, the Linux community *lives* this for many
years now)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
