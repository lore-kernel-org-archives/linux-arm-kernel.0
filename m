From: atull@opensource.altera.com (atull)
Date: Thu, 25 Sep 2014 12:10:34 -0500
Subject: [PATCH 2/2] socfpga: support suspend to ram
In-Reply-To: <20140925082506.GC26991@pengutronix.de>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-3-git-send-email-atull@opensource.altera.com>
 <20140925082506.GC26991@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1409251200490.693@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On Thu, 25 Sep 2014, Steffen Trumtrar wrote:

> Hi!
> 
> On Wed, Sep 24, 2014 at 03:27:29PM -0500, atull at opensource.altera.com wrote:
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add code that requests that the sdr controller go into
> > self-refresh mode.  This code is run from ocram.
> > 
> > This patch assumes that u-boot has already configured sdr:
> >   sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> >   sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> >   sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> > 
> > How to suspend to ram:
> >  $ echo enabled > \
> > /sys/devices/soc/ffc02000.serial0/tty/ttyS0/power/wakeup
> > 
> >  $ echo -n mem > /sys/power/state
> > 
> 
> (...)
> 
> Never looked into that, so maybe a stupid question:
> What happens if the bootloader (u-boot or other) didn't configure the sdr?
> Will it "just" not wake up again?

Waking up won't be the problem.  Linux won't boot.

Alternatively, if this Linux kernel is paired with a version of the
bootloader that does most of the initializion, but not the settings
that we want here, I expect there could be issues.

I don't want to duplicate the u-boot sdr configuration code, instead
I document my assumptions here here.  For future generations who take
this patch.  If they have a problem with s2r, they will look through
the git logs and find this helpful note of what their bootloader
was supposed to do.

Alan

> 
> Regards,
> Steffen
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
