From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 17:18:00 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.15 (#1)
In-Reply-To: <87lghc9urs.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 05 Jan 2018 16:42:47 +0100")
References: <87lghc9urs.fsf@free-electrons.com>
Message-ID: <87bmi89t53.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., janv. 05 2018, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> Here is the first pull request for fixes for mvebu for v4.15.
>
> Gregory
>
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.15-1
>
> for you to fetch changes up to fefb476bc7fdda4cb1e768493128c15a896f2c4e:
>
>   ARM64: dts: marvell: armada-cp110: Fix clock resources for various node (2018-01-05 16:04:53 +0100)
>

Actually I fix the commit log of the patch "ARM64: dts: marvell:
armada-cp110: Fix clock resources for various node" by replacing
"logical" by "functional" which should make more sens. That means the
the commit ID had changes and should be:

e3af9f7c6ece29fdb7fe0aeb83ac5d3077a06edb:

  ARM64: dts: marvell: armada-cp110: Fix clock resources for various node (2018-01-05 16:54:40 +0100)

Gregory


> ----------------------------------------------------------------
> mvebu fixess for 4.15 (part 1)
>
> 2 device tree related fixes fixing 2 issues:
>  - broken pinctrl support since 4.11 on OpenBlocks A7
>  - implicit clock dependency making the kernel hang if the Xenon sdhci
>    module was loaded before the mvpp2 Ethernet support (for this one
>    the driver had to be fixed which was done in v4.14)
>
> ----------------------------------------------------------------
> Gregory CLEMENT (1):
>       ARM64: dts: marvell: armada-cp110: Fix clock resources for various node
>
> Thomas Petazzoni (1):
>       ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7
>
>  arch/arm/boot/dts/kirkwood-openblocks_a7.dts         | 10 ++++++++--
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 13 ++++++++-----
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  9 ++++++---
>  3 files changed, 22 insertions(+), 10 deletions(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
