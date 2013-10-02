From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 2 Oct 2013 10:51:13 -0300
Subject: [GIT PULL] ARM: mvebu: fixes for v3.12
In-Reply-To: <20130920034613.GB11119@titan.lakedaemon.net>
References: <20130920034613.GB11119@titan.lakedaemon.net>
Message-ID: <20131002135112.GA2621@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 11:46:13PM -0400, Jason Cooper wrote:
> Guys,
> 
> We have a relatively long list of fixes this time around.  The two
> of_node_put()'s were left over from before the merge window (part of
> mvebu/fixes-non-critical).
> 
> The two for the Armada XP clocks are to fix booting v3.12-rc1 since the
> corresponding driver changes were merged at the last minute.  These were
> originally part of mvebu/dt for v3.12, but have since become fixes.
> 
> The other two just cropped up since v3.12-rc1 dropped.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
> 
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/fixes-3.12
> 
> for you to fetch changes up to ddf7e399024aa908573a08d6339cefa6253b83db:
> 
>   ARM: kirkwood: Fix address of second XOR engine (2013-09-20 03:16:20 +0000)
> 
> ----------------------------------------------------------------
> mvebu fixes for v3.12
> 
>  - mvebu
>     - fix reference leaks by adding of_node_put()
>     - update Armada XP DT clock properties to restore booting
> 
>  - kirkwood
>     - add missing reg property for cpu at 0
>     - fix typo in address of second XOR engine
> 
> ----------------------------------------------------------------
> Andrew Lunn (1):
>       ARM: Kirkwood: Add missing DT reg property to cpu at 0
> 
> Ezequiel Garcia (2):
>       ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
>       ARM: mvebu: Add clock properties to Armada XP timer node
> 

For some reason, I'm not seeing the above two in v3.12-rc3.

Guys: what happened? We need these to boot successfully...

> Jisheng Zhang (2):
>       ARM: mvebu: add missing of_node_put() to fix reference leak
>       bus: mvebu: add missing of_node_put() to fix reference leak
> 
> Quentin Armitage (1):
>       ARM: kirkwood: Fix address of second XOR engine
> 
>  arch/arm/boot/dts/armada-xp.dtsi        | 11 +++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi         |  3 ++-
>  arch/arm/mach-mvebu/coherency.c         |  8 +++++++-
>  arch/arm/mach-mvebu/pmsu.c              |  1 +
>  arch/arm/mach-mvebu/system-controller.c |  1 +
>  drivers/bus/mvebu-mbus.c                |  6 +++++-
>  6 files changed, 27 insertions(+), 3 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
