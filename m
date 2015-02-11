From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Feb 2015 10:42:59 +0100
Subject: Recommendations for a new MFD device driver?
In-Reply-To: <20150210072039.GC8020@x1>
References: <20150206101006.GK12209@pengutronix.de> <20150210072039.GC8020@x1>
Message-ID: <20150211094259.GL12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 03:20:39PM +0800, Lee Jones wrote:
> On Fri, 06 Feb 2015, Sascha Hauer wrote:
> 
> > Hi All,
> > 
> > We are adding support for a new pretty typical MFD device, the MediaTek
> > MT6397. Initial patches are already posted. It's a PMIC which among other
> > things has regulators and a RTC. The same RTC is reused on another PMIC,
> > but with another register offset and another interrupt.
> > 
> > Now the question is where shall we put the register/irq resource
> > information?
> > 
> > 1) Put it into the RTC device driver.
> > 2) Put it into the .resource field of struct mfd_cell
> > 3) Put it into the device tree using standard reg, interrupt properties and
> >    a) Let the RTC driver interpret these
> >    b) Let the MFD driver create resources in the .resource field of struct
> >       mfd_cell
> >    c) Let the MFD core create the resources
> 
> I have no problem with 2, if that's the route you'd like to take.

Ok, thanks Lee and Mark for the input. I think we should go with option
2 then. While it's convenient to put the resources into the device tree
in the first place, it probably becomes cumbersome when Linux gets a
different idea how the subdevices of the PMIC should be arranged.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
