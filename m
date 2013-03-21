From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 09:26:10 -0300
Subject: [PATCH 00/16] Marvell EBU thermal sensor consolidation
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130321122609.GB22714@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 07:36:21PM -0300, Ezequiel Garcia wrote:
> This patchset is my first attempt at adding basic thermal sensor
> support on Armada 370 and Armada XP.
> 
> Given Armada 370/XP and the other Marvell SoC with thermal support,
> namely Kirkwood and Dove, have fairly similar thermal devices it 
> made sense to integrate all of them into a single driver: mvebu-thermal.
> 
> The patches have been carefully splitted to make the changeset
> as less invasive as possible. These changes can be divided in five stages:
> 
>   1. Rename 'kirkwood' driver to 'mvebu'
>   2. Some fixes inherited from kirkwood driver applied to new mvebu driver
>   3. Prepare mvebu driver to support multiple SoC
>   4. Add thermal support for each Marvell SoC on top of mvebu driver
>   5. Add device tree nodes for Armada 370 and Armada XP
>   6. Fix defconfigs for all the platforms involved
> 
> Testing have been done on the following boards:
> 
> Kirkwood:   Plat'home Openblocks A6
> Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
> Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV784MP-GP
> 
> Dove is *not* tested due to lack of hardware.
> 

If anyone wants to test this patchset, I've prepared a public branch:

https://github.com/MISL-EBU-System-SW/mainline-public/tree/mvebu-thermal-v1

This branch is based on v3.9-rc1, with this patches:
  arm: mvebu: Reduce reg-io-width with UARTs
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283
  Dove: Thermal: Add DT node and enable in defconfig

Thanks a lot,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
