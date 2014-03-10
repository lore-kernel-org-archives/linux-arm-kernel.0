From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Mar 2014 11:09:26 -0400
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.15
In-Reply-To: <20140301025919.GQ1872@titan.lakedaemon.net>
References: <20140301025919.GQ1872@titan.lakedaemon.net>
Message-ID: <20140310150926.GJ18707@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

I see you went through and handled quite a few pull requests this
weekend, but it looks like you skipped over this one I've replied to and:

[GIT PULL] ARM: mvebu: driver changes for v3.15
[GIT PULL] ARM: mvebu: soc changes for v3.15 (incr. pull #2)
[GIT PULL V2] ARM: mvebu: dt changes for v3.15 (incr. pull #3)
[GIT PULL] ARM: mvebu: defconfig changes for v3.15 (incr. pull #2)

It looks like I sent to arm at kernel.org on all of them, is there
something else I missed?

There's also another round of pull requests sent more recently, but I
haven't gotten that far through lakml yet. :)

thx,

Jason.

On Fri, Feb 28, 2014 at 09:59:19PM -0500, Jason Cooper wrote:
> Guys,
> 
> Here's a collection of small changes to drivers relevant to mvebu SoCs.
> We typically take the mbus changes through arm-soc.  The rtc maintainer
> has expressed preferences for driver changes to go through the concerned
> SoC tree.  The config oneliners for the kirkwood move have been Acked by
> the major subsystem maintainers.
> 
> All changes have been in -next at least 4 days.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-3.15
> 
> for you to fetch changes up to ff1f0018cf66080d8e6f59791e552615648a033a:
> 
>   drivers: Enable building of Kirkwood drivers for mach-mvebu (2014-02-24 17:28:31 +0000)
> 
> ----------------------------------------------------------------
> mvebu drivers for v3.15
> 
>  - mvebu mbus
>     - use of_find_matching_node_and_match
> 
>  - rtc
>     - use PTR_ERR_OR_ZERO in isl12057
>     - work around issue in mv where date returned is 2038
> 
>  - kirkwood -> mach-mvebu
>     - various Kconfig oneliners to allow building kirkwood in -mvebu/
> 
> ----------------------------------------------------------------
> Andrew Lunn (1):
>       drivers: Enable building of Kirkwood drivers for mach-mvebu
> 
> Fengguang Wu (1):
>       rtc: isl12057: use PTR_ERR_OR_ZERO to fix coccinelle warnings
> 
> Josh Cartwright (1):
>       bus: mvebu-mbus: make use of of_find_matching_node_and_match
> 
> Thomas Petazzoni (1):
>       rtc: mv: reset date if after year 2038
> 
>  drivers/bus/mvebu-mbus.c    |  3 +--
>  drivers/cpufreq/Kconfig.arm |  2 +-
>  drivers/cpuidle/Kconfig.arm |  2 +-
>  drivers/leds/Kconfig        |  4 ++--
>  drivers/phy/Kconfig         |  2 +-
>  drivers/rtc/rtc-isl12057.c  |  5 +----
>  drivers/rtc/rtc-mv.c        | 12 ++++++++++++
>  drivers/thermal/Kconfig     |  2 +-
>  sound/soc/kirkwood/Kconfig  |  2 +-
>  9 files changed, 21 insertions(+), 13 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
