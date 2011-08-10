From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Aug 2011 05:21:18 -0700
Subject: Remaining omap pull requests
In-Reply-To: <4E389102.1050302@ti.com>
References: <20110711114736.GX5783@atomide.com>
	<201107120016.12366.arnd@arndb.de>
	<20110713061634.GG5783@atomide.com> <4E3884EE.3070507@ti.com>
	<4E389102.1050302@ti.com>
Message-ID: <20110810122118.GK1939@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110802 17:00]:
> On 08/02/2011 04:14 PM, Kevin Hilman wrote:
> [...]
> >>
> >>Looks like I forgot the i2c driver changes that also should be
> >>merged by us. Those are acked by Ben Dooks, Kevin's pull request
> >>for that is at:
> >>
> >>http://marc.info/?l=linux-omap&m=131014213007667&w=2
> >>
> >
> >I thought this was already pulled, but looking now I see that this was
> >never pulled into the arm-soc tree.
> >
> >Can you pull this for v3.1 please?

I'll send a pull request for Ben Dooks for this as now the conflicting
parts have been merged.
 
> Oops, I had to rebase this branch as Paul had picked up a few of
> these patches for his fixes (which are now part of
> arm-soc/next/fixes2.) Updated pull request below.
> 
> Also, I noticed there's a minor conflict with something coming from the
> trivial tree[1].

Looks like i2c-andy-2 still fails to merge cleanly on top of v3.1-rc1.
Will resolve for Ben and proxy the pull request while you're on vacation.

Regards,

Tony
 

> The following changes since commit 6d3c55fd4f0f94a9455d30df9414ddb0f755f402:
> 
>   OMAP: hwmod: fix the i2c-reset timeout during bootup (2011-07-10
> 05:27:16 -0600)
> 
> are available in the git repository at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> for_3.1/i2c-andy-2
> 
> Andy Green (12):
>       I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
>       I2C: OMAP: add rev to omap i2c platform data
>       I2C: OMAP1: set IP revision in platform data
>       I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when
> i2c bus added
>       I2C: OMAP2+: use platform_data ip revision to select register map
>       I2C: OMAP2+: Solve array bounds overflow error on i2c idle
>       I2C: OMAP2+: address confused probed version naming
>       I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
>       I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
>       I2C: OMAP1: set i2c unit feature implementation flags in
> platform data
>       I2C: OMAP2+: Convert omap I2C driver to use feature
> implementation flags from platform data
>       I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version
> shown in dev_info
> 
>  arch/arm/plat-omap/i2c.c      |   27 +++++++++++
>  drivers/i2c/busses/i2c-omap.c |  100
> ++++++++++++++++++++++------------------
>  include/linux/i2c-omap.h      |    2 +
>  3 files changed, 84 insertions(+), 45 deletions(-)
> 
> 
> [1]
> commit 32575a9183c82a5ea0f9ed1bcf13c17189ea1118
> Author: Jesper Juhl <jj@chaosbits.net>
> Date:   Sat Jul 9 23:20:42 2011 +0200
> 
>     drivers/i2c: static should be at beginning of declaration
> 
>     Make sure that the 'static' keywork is at the beginning of declaration
>     for drivers/i2c/busses/i2c-omap.c
> 
>     This gets rid of warnings like
>       warning: ?static? is not at beginning of declaration
>     when building with -Wold-style-declaration (and/or -Wextra which also
>     enables it).
> 
>     Signed-off-by: Jesper Juhl <jj@chaosbits.net>
>     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
