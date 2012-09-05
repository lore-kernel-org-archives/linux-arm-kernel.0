From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 09:12:21 +0800
Subject: [PATCH v3 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <201209050118.39045.rjw@sisk.pl>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-4-git-send-email-shawn.guo@linaro.org>
 <201209050118.39045.rjw@sisk.pl>
Message-ID: <20120905011219.GN2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 01:18:38AM +0200, Rafael J. Wysocki wrote:
> On Friday, August 10, 2012, Shawn Guo wrote:
> > It adds a generic cpufreq driver for CPU0 frequency management based on
> > clk, regulator, OPP and device tree support.  It can support both
> > uniprocessor (UP) and those symmetric multiprocessor (SMP) systems which
> > share clock and voltage across all CPUs.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I seem to recall that this has been discussed with several people and
> undergone some changes as a result of comments.  Would it be possible
> to get some ACKs from the people involved?
> 

Mark, Santosh,

Reviewed-by, please?

AnilKumar,

Tested-by, please?

<snip>

> > --- /dev/null
> > +++ b/drivers/cpufreq/cpufreq-cpu0.c
> > @@ -0,0 +1,271 @@
> > +/*
> > + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> > + *
> > + * Reuse some codes from drivers/cpufreq/omap-cpufreq.c
> 
> What do you mean by "reuse" here?
> 
cpu0_set_target() function is almost a copy of omap_target() from
drivers/cpufreq/omap-cpufreq.c.  I should probably just say so?

> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> 
> The kernel is just GPLv2 (not later) and it will stay this way.  Please
> update this comment accordingly.
> 
Okay.

> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */

-- 
Regards,
Shawn
