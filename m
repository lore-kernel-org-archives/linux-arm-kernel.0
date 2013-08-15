From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Thu, 15 Aug 2013 10:00:40 +0200
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
Message-ID: <1376553640.3889.70.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-14 at 15:21 -0700, Russ Dill wrote:
> > The CM3 driver needs to figure out where the core regulator is connected
> > using using either DT or the regulator framework and ask the TPS (via a
> > new interface) for register writes for sleep/wake sequences. Then those
> > sequences will actually match the correct voltages configured using
> > DT/DVFS.
> 
> That seems like it'd add a lot of complexity to the regulator
> subsystem, as well as all the PMIC and other I2C regulators that any
> users of these device tree properties may end up using for not a lot
> of gain. There would be two separate code paths for any used
> I2C regulator or PMIC for setting voltages.

Yes, it would be additional complexity, but it would avoid duplicating
information which is already in the DT (location&address of the PMIC,
type of pmic) and in the kernel (how to program voltages for a given
regulator). As DT is supposed to describe the hardware, duplicate
information should be unnecessary.

One different way to look at this is that the CM3 firmware is a separate
consumer of the DT. DT being OS-indepentent, the CM3 firmware should be
able to get all the information it needs from the DT (maybe with help
from the CM3 driver).

Regards,
Jan 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
