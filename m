From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 21:34:35 -0700
Subject: [GIT PULL] Kirkwood: board changes for v3.7
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120905043435.GB6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,


On Tue, Aug 28, 2012 at 08:11:29PM -0400, Jason Cooper wrote:
> The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> 
>   Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7-v2

Hmm, this branch contains one duplicate patch due to me applying one
straight to our fixes branch ("ARM: Kirkwood: Fix 'SZ_1M' undeclared here
for db88f6281-bp-setup.c"). I also didn't see that mentioned in the pull
request below, so I'm guessing you added it afterwards. There are also a
couple of merge conflicts with other fixes we have already pulled in from
you, it'd be nice if you just based this branch on those fixes instead.

Also, I wonder if I could have you split up this branch a bit more? My
suggestions are below. You can have branches build on top of each other where
there are dependencies, just please point them out when you send the pull
requests.


Let me know if I'm unclear or if there's something that doesn't make sense,
I'll be happy to help.


-Olof


> 
> Alan M Butler (1):
>       ARM: Kirkwood: Iomega ix2-200 DT support

New board, so can stay in boards branch

> 
> Arnaud Patard (3):
>       ARM: Kirkwood: Describe iconnect keys in DT.
>       ARM: Kirkwood: Describe iconnect nand in DT.

dt branch material

>       ARM: Kirkwood: fix Makefile.boot

fixes for 3.6, or fixes-non-critical that we pick up before anything else in
3.7, your choice.

> Jason Cooper (5):
>       ARM: Kirkwood: board-dockstar: use linux/platform_data/mvsdio.h instead of plat/mvsdio.h   
>       ARM: Kirkwood: use linux/platform_data/mv643xx.h instead of linux/mv643xx.h
>       ARM: Kirkwood: Kconfig: keep DT boards together

Those would be cleanup

>       ARM: Kirkwood: update defconfig
>       ARM: Kirkwood: add DT boards to defconfig

defconfig branch

> 
> Sebastian Hesselbarth (2):
>       ARM: kirkwood: DT board setup for Seagate FreeAgent Dockstar
>       ARM: kirkwood: DT descriptor for Seagate FreeAgent Dockstar

new boards, board branch

> 
> Thomas Petazzoni (15):
>       arm: add documentation describing Marvell families of SoC

SoC branch or board branch

>       mtd: orion_nand: remove <mach/hardware.h> include

cleanup

>       arm: plat-orion: use 'void __iomem *' in addr-map code

Hmm, I would prefer if the actual constants were annotated instead of cast in
the code here. See how we handled that on tegra with IOMEM(). That will also
help sparse catch unannotated uses of those constants.

>       arm: plat-orion: introduce PLAT_ORION_LEGACY hidden config option

cleanup or soc

>       arm: plat-orion: make bridge_virt_base non-const to support DT use case

Hm, dt I suppose.

>       arm: mvebu: add basic address decoding support to Armada 370/XP
>       arm: mvebu: add address decoding controller to the DT

soc patches, I'd say

>       sound: kirkwood: remove useless <plat/audio.h> include
>       sound: kirkwood: move <plat/audio.h> to <linux/platform_data/kirkwood-audio.h>  
>       usb: ehci-orion: move <plat/ehci-orion.h> to <linux/platform_data/ehci-orion.h> 
>       mmc: mvsdio: move <plat/mvsdio.h> to <linux/platform_data/mvsdio.h>
>       dma: mv_xor: move <plat/mv_xor.h> to <linux/platform_data/mv_xor.h>
>       mtd: orion_nand: move <plat/orion_nand.h> to <linux/platform_data/orion_nand.h>
>       i2c: mv643xx: move <linux/mv643xx_i2c.h> to <linux/platform_data/mv643xx_i2c.h>
>       net: mv643xx_eth: move <linux/mv643xx_eth.h> to <linux/platform_data/mv643xx_eth.h>

All above are cleanup.


-Olof
