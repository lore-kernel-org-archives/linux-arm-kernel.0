From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Mar 2013 14:59:41 -0400
Subject: [PATCH v2 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130317185941.GA13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, Mar 06, 2013 at 05:59:55PM +0100, Thomas Petazzoni wrote:
...
> Summary of the patch set:
> 
>  * Patch 1 makes the compilation of plat-orion/addr-map.c conditional
>    on a per-SoC family basis. This allows patches 5 to 9 to
>    progressively move each SoC family to use the mvebu-mbus driver
>    instead of the mach-<foo>/addr-map.c + plat-orion/addr-map.c
>    code. Notice that the plat-orion/addr-map.c code cannot be compiled
>    in a kernel that has the mvebu-mbus, due to the namespace conflict
>    on the mv_mbus_dram_info() function.
> 
>  * Patch 2 and 3 ensures that all places that need to have access to
>    the list of DRAM address decoding windows do so by using the public
>    mv_mbus_dram_info() rather than directly accessing an internal
>    structure.

applied to mvebu/cleanup

>  * Patch 4 introduces the mvebu-mbus driver itself, with the support
>    for all 5 Marvell EBU SoC families. Note that the driver is
>    compiled through a blind option, because we don't want the driver
>    to be compiled in unless the corresponding sub-architecture has
>    been migrated to use it: as explained above, compiling the driver
>    conflicts with compiling the plat-orion/addr-map.c code.

applied to mvebu/drivers as there doesn't appear to be a drivers/bus
maintainer other than arm-soc contributions...

>  * Patch 5 to 9 moves each Marvell EBU sub-architecture to use the
>    mvebu-mbus driver.

small note: I had to remove line 9 '/dts-v1/;' from orion5x-88f5182.dtsi
in order to get orion5x-lacie-ethernet-disk-mini-v2.dts to build.

I squashed this change into:

  arm: mach-orion5x: convert to use mvebu-mbus driver

>  * Patch 10 removes the now unused plat-orion/addr-map.c code.

applied patches 5-10 to mvebu/soc


Very well organized to facilitate import and reduce dependency
headaches, Thanks!

thx,

Jason.
