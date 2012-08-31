From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 31 Aug 2012 15:05:02 +0200
Subject: i.MX pwm patches
In-Reply-To: <20120830214547.GC3613@r65073-Latitude-D630>
References: <1346154504-5623-1-git-send-email-s.hauer@pengutronix.de>
 <20120830214547.GC3613@r65073-Latitude-D630>
Message-ID: <20120831130502.GR26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 05:45:49AM +0800, Shawn Guo wrote:
> On Tue, Aug 28, 2012 at 01:48:15PM +0200, Sascha Hauer wrote:
> > Hi All,
> > 
> > The following patches are an overdue work on the i.MX pwm driver.
> > 
> > - introduce SoC specific functions to make the driver easier to maintain
> > - use peripheral clock for pwm output unconditionally
> > - separate the two clocks this module has
> > - enable ipg clock for register accesses, peripheral clock for enabling
> >   the pwm
> > - make the driver safe for calling pwm_config before pwm_enable
> > - Add devicetree support for i.MX53
> > 
> > The platform device support is still implemented using cpu_is_*, I think
> > this can be dropped completely soon
> 
> Anything stops us from doing this right now?  The bonus point of
> cleaning this is that we can remove the #include <mach/hardware.h>
> from the driver, which is helpful for single-kernel project.

The pwm driver currently has no in kernel user, so I'd say yes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
