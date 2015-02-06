From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Feb 2015 11:10:06 +0100
Subject: Recommendations for a new MFD device driver?
Message-ID: <20150206101006.GK12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

We are adding support for a new pretty typical MFD device, the MediaTek
MT6397. Initial patches are already posted. It's a PMIC which among other
things has regulators and a RTC. The same RTC is reused on another PMIC,
but with another register offset and another interrupt.

Now the question is where shall we put the register/irq resource
information?

1) Put it into the RTC device driver.
2) Put it into the .resource field of struct mfd_cell
3) Put it into the device tree using standard reg, interrupt properties and
   a) Let the RTC driver interpret these
   b) Let the MFD driver create resources in the .resource field of struct
      mfd_cell
   c) Let the MFD core create the resources

I have a tendency to 3, but I'm afraid that the resource informations
are duplicated too much in the device tree source files, because every
user would have to carry a full description of the mfd device. Maybe
that duplication could be reduced with some CPP magic, I don't know.

Maybe this is a solved problem and I'm just not picking a good example
from drivers/mfd.

Any thoughts?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
