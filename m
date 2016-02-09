From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 16:23:20 +0100
Subject: [PATCH v3 00/12] Add support for the Armada 3700 SoC an mvebu
 ARM64 based
In-Reply-To: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <3329016.IcNNJBVSgr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 18:14:08 Gregory CLEMENT wrote:
> This series introduce the support of the Armada 3700 family: it is the
> first ARM64 SoC of the mvebu family submitted to the mainline!
> 
> Currently there are two members of the Armada 3700 family, the only
> difference is the number of core: the Armada 3710 comes with one
> Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
> series we enabled only the minimum to boot, pinctrl and clock tree
> will come soon.
> 
> The changes in this third version are very small (see the changelog).
> 
> The first two patches patches are here to be able to use the the
> ARCH_MVEBU for the Armada 3700 SoCs. The first ones is only here to
> have standalone series but it comes from Thomas Petazzoni's series:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/472625
> 
> The third patch introduces a new serial driver for the uart used on
> this SoC. The driver remains simple even if the hardware is capable of
> doing more.
> 
> The forth one adapts the ahci driver to support the Armada 3700 SoC.
> The forth patch updates the binding documentation with the new
> compatible string.
> 
> The fifth patch adds a new entry Kconfig entry for this SoC family.
> 
> I took the opportunity of this series to tidy up the Marvell related
> files in the binding documentation with the seventh patch.
> 
> The eighth patch introduces the compatible string for the SoCs of the
> Armada 3700 family.
> 
> The ninth patch could be considered as the bulk of this series: it
> adds the device tree files for the Armada 3700 SoCs and for the
> reference board.
> 
> With the introduction of this new family the MAINTAINERS file, the
> Marvell README and the ARM64 defconfig files have to be updated: it is
> the purpose of the last 3 patches.
> 
> The patches 3 and 4 could be taken directly by the maintainer of their
> respective subsystem as there is no dependency at all with the rest of
> the series. I think that the rest of the series should go through the
> arm-soc maintainer but in doubt I also added the ARM64 maintainer as
> suggested by get_maintainer.pl.
> 
> 

Looks good overall,

Acked-by: Arnd Bergmann <arnd@arndb.de>
