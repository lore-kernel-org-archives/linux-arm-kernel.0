From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 10:50:54 +0800
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120711205031.a6622a96311bdcc273272621@freescale.com>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
 <20120706002254.GB20175@S2101-09.ap.freescale.net>
 <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
 <20120709065116.GB11635@S2101-09.ap.freescale.net>
 <20120709194514.e6a854441fa69a54fadc296d@freescale.com>
 <20120710023226.GA19649@S2101-09.ap.freescale.net>
 <20120710190221.0f26b6f158257b00c40e6a4e@freescale.com>
 <20120711025753.GA14060@S2101-09.ap.freescale.net>
 <20120711205031.a6622a96311bdcc273272621@freescale.com>
Message-ID: <20120712025053.GH6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 08:50:31PM -0500, Kim Phillips wrote:
> On Wed, 11 Jul 2012 10:57:55 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > On Tue, Jul 10, 2012 at 07:02:21PM -0500, Kim Phillips wrote:
> > > how, without the "simple-bus" addition to the sec_mon compatibles
> > > list in the imx6 device tree (which isn't present in this patch)?
> > > 
> > This patch does not present anything about sec_mon node.
> 
> it makes a change to its definition in the device tree documentation.
> 
> >  It's all about sec_mon_rtc_lp node.
> 
> the change is that the sec_mon node now includes the sec_mon_rtc_lp
> node, and they are related, just as in h/w.
> 
I'm primarily talking about drivers/rtc/rtc-snvs.c.  There is no change
required on drivers/rtc/rtc-snvs.c whether the device is created by
a sec_mon driver or "simple-bus" approach.

> > The driver itself does not know if the
> > rtc_lp node is a subnode of sec_mon node at all.
> 
> I understand that, but as it stands (and AFAICT), this patch by
> itself doesn't enable the driver to be probed on _any_ platform,
> including ARM.
> 
It's never a thing that RTC driver should care.  As long as the driver
is verified to be functional, it's platform's call to enable the device
or not on particular board/system.

> > Can you please tell me what exact change you expect me to make on
> > drivers/rtc/rtc-snvs.c?  The patch merely adds a lp-rtc driver and
> > should not include any platform specific changes (dts, etc.)  The
> > driver and dts changes are two orthogonal parts, and should go via
> > RTC tree and ARCH tree separately.
> 
> That's odd; I would expect all enabling changes to either be
> included in the same patch, or at least in the same patchseries, and
> one subsystem maintainer ack the other.  If ARM-related patch
> processes differ somehow, then so be it.
> 
I don't think it's an ARM-related process.  The process you mentioned
is only used for particular case where a series touches multiple
subsystems while the whole series has to go via one tree in order to
maintain "git bisect".  Since there is no bisect for a new driver to
maintain at all, it should just follow the general process, having
patches go via respective subsystem tree to minimize the merge conflicts
when different trees get merged together.

-- 
Regards,
Shawn
