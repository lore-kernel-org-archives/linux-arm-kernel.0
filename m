From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 16 Apr 2014 10:17:54 +0200
Subject: [PATCH v2 0/4] ARM: mvebu: fix bus width handling in mvebu-devbus
In-Reply-To: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534E3CB2.3010505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 14/04/2014 17:29, Thomas Petazzoni wrote:
> Jason, Greg, Andrew, Sebastian,
> 
> This set of patches fix a bug in the mvebu-devbus driver, which was
> leading to a misinterpretation of Device Tree provided value: a NOR
> bus width declared as 8 bits in the Device Tree was in fact configured
> as 16 bits at the hardware level.
> 
> This bug was not noticed until now, because it was compensated by a
> symetric mistake in the Device Tree files.
> 
> This set of commits therefore fix both the driver itself, and the
> incorrect Device Tree files. The patches for the Device Tree files
> have been separated, because some of them should apply all the way to
> v3.10, while some of them apply only up to v3.11.
> 
> Changes since v1:
> 
>  * Added patches to fix the Device Tree files to indicate the correct
>    bus width, as documented in the board schematics. Noticed by
>    Ezequiel Garcia.
> 
>  * Changed the bus_width conversion logic in the driver to only accept
>    valid values: 8 bits and 16 bits. All other values lead to an error
>    being returned. Suggested by Sebastian Hesselbarth.
> 
>  * Rebased on top of v3.15-rc1.

Everything looks good so for the whole series:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (4):
>   memory: mvebu-devbus: fix the conversion of the bus width
>   ARM: mvebu: fix NOR bus-width in Armada XP GP Device Tree
>   ARM: mvebu: fix NOR bus-width in Armada XP DB Device Tree
>   ARM: mvebu: fix NOR bus-width in Armada XP OpenBlocks AX3 Device Tree
> 
>  arch/arm/boot/dts/armada-xp-db.dts               |  2 +-
>  arch/arm/boot/dts/armada-xp-gp.dts               |  2 +-
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  2 +-
>  drivers/memory/mvebu-devbus.c                    | 15 +++++++++++++--
>  4 files changed, 16 insertions(+), 5 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
