From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 5 Jan 2012 11:21:11 +0800
Subject: [RFC PATCH v2 2/2] ARM: imx: Add mx5 cpuidle implmentation
In-Reply-To: <CAMXH7KEHsighKYkPhhgHmE9s7sxtP4hz8L+Z+LMsrD14kiqJJQ@mail.gmail.com>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-3-git-send-email-rob.lee@linaro.org>
 <20111222175027.GG29622@opensource.wolfsonmicro.com>
 <CAMXH7KEHsighKYkPhhgHmE9s7sxtP4hz8L+Z+LMsrD14kiqJJQ@mail.gmail.com>
Message-ID: <20120105032110.GC14741@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 05:35:39PM -0600, Rob Lee wrote:
> On 22 December 2011 11:50, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Dec 14, 2011 at 01:02:06AM -0600, Robert Lee wrote:
> >
> >> + ? ? clk_enable(&gpc_dvfs_clk);
> >
> > Should these enables be in the cpuidle code? ?The device appears to have
> > been working fine without them thus far... ?Alternatively, if they
> > should be on anyway does this need to be split out and sent as a bug
> > fix?
> 
> This clock is used by the existing pm_suspend code for i.MX51 and
> other future code being worked on.  Since it uses extremely minimal
> power and is required to be enabled during low power modes, it seemed
> cleanest to just enable it during clock init.

+1

Regards,
Shawn

> But I forgot to remove
> it from it's enabling from i.MX51 pm_suspend code so I can do that for
> v3.
> 
