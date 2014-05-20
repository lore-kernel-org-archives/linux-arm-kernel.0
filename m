From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 22:01:09 -0700
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.16
In-Reply-To: <20140509142717.GM12708@titan.lakedaemon.net>
References: <20140509142717.GM12708@titan.lakedaemon.net>
Message-ID: <20140520050109.GG18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 10:27:17AM -0400, Jason Cooper wrote:
> guys,
> 
> Here's the bulk of the changes in mvebu-land this cycle.  A lot of new
> capability for Armada 375/38x, and a sprinkle of stuff for the other
> mvebu SoCs.  These changes have been in -next for almost two weeks, a
> couple of bugs were discovered during this period and fixed.
> 
> As noted in the tag message, there is an external dependency on the
> mvebu/irqchip branch already pulled by tglx.  If you'd like to keep a
> copy locally you can pull:
> 
> DEP: git://git.infradead.org/linux-mvebu.git tags/irqchip-mvebu-3.16
> 
> (I'm hoping the 'DEP:' prevents your script for automagically pulling
> the wrong branch ;-) )
> 
> I've included the changes to the cpuidle driver in here because they
> depend on changes in mvebu/soc, and subsequent changes in mvebu/soc
> depend on the changes to the cpuidle driver. Not ideal, but better than
> complicated branch deps.
> 
> The same goes for the mvebu-bus driver, but there is no assigned
> maintainer for drivers/bus, so we usually handle those ourselves.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.16
> 
> for you to fetch changes up to 9f0affcf3e21fc56d8bce625bb3d5800b7a7d284:
> 
>   ARM: mvebu: Fix pmsu compilation when ARMv6 is selected (2014-05-08 16:55:55 +0000)
> 
> ----------------------------------------------------------------
> mvebu SoC changes for v3.16
> 
>  - Armada 375/38x coherency support
>  - Armada 375/38x SMP support
>  - mvebu PMSU and CPU reset support
>  - Armada 370/XP cpuidle support
>  - kirkwood remove platform init of audio device
>  - small fixes and cleanup for new SoC (375/38x)
> 
> Note:
>  - due to complex deps, cpuidle changes Acked by appropriate maintainer for
>    going though arm-soc tree.
> 
> Depends:
>  - tags/irqchip-mvebu-3.16 in the mvebu/irqchip branch (tglx already pulled) for:
> 
>     d7df84b3ceca irqchip: irq-armada-370-xp: Use cpu notifier to initialize secondary CPUs
>     ef37d337e1d3 irqchip: irq-armada-370-xp: Do the set_smp_cross_call() in the driver

Merged, thanks. Same comment on depends as before -- please move up to the
email. Not a huge deal but I do end up pruning them out of the merge commit
message.


-Olof
