From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 11:39:19 +0000
Subject: [PATCH v1 0/24] Zynq DT changes
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <20140103113919.GI7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why are you cross posting this to linux-arm-kernel?  There's already
enough traffic on this list without having u-boot patches also posted
here.

I think you're the only one who does this, so please refrain from doing
so in the future.  Those who are interested in uboot development will
already be subscribed to the uboot mailing list.

Thanks.

On Fri, Jan 03, 2014 at 11:10:45AM +0100, Michal Simek wrote:
> Hi,
> 
> this is respin of Jagan v3 series sent here
> http://lists.denx.de/pipermail/u-boot/2013-December/169617.html
> + 2 patches v4
> http://lists.denx.de/pipermail/u-boot/2013-December/169753.html
> http://lists.denx.de/pipermail/u-boot/2013-December/169752.html
> 
> The purpose of this series was to synchronized configuration
> which we are using with mainline version with adding features
> which we are using.
> 
> The major change, which I have done, is adding DT support for
> all zynq boards instead of board specification configurations.
> I have changed serial, gem, emaclite, mmc.
> i2c, spi already support bus selection.
> 
> For more information please look at patches.
> 
> All series are available here for easier testing.
> http://git.denx.de/?p=u-boot/u-boot-microblaze.git;a=shortlog;h=refs/heads/zynq
> 
> Thanks,
> Michal
> 
> Changes in v1:
> - Remove doc compare to origin Jagan version
> - Update to the latest status
> 
> Jagannadha Sutradharudu Teki (19):
>   gpio: zynq: Add dummy gpio routines
>   zynq: Enable CONFIG_FIT_VERBOSE
>   zynq: Enable Boot FreeBSD/vxWorks
>   zynq: Cleanup on miscellaneous configs
>   zynq: Cleanup on memory configs
>   zynq: Minor config cleanup
>   zynq: Enable cache options
>   zynq: serial: Simplify serial driver initialization
>   zynq: Add GEM0, GEM1 configs support
>   zynq-common: Define exact TEXT_BASE
>   zynq: Add Catalyst 24WC08 EEPROM config support
>   zynq-common: Define default environment
>   zynq-common: Change Env. Sector size to 128Kb
>   zynq-common: Define flash env. partition
>   zynq-common: Define CONFIG_ENV_OVERWRITE
>   zynq: Add support to find bootmode
>   dts: zynq: Add fdt support
>   zynq-common: Enable verified boot(RSA)
>   doc: zynq: Add information on zynq u-boot
> 
> Michal Simek (5):
>   net: emaclite: Fix OF initialization
>   net: gem: Add OF initialization support
>   mmc: zynq: Add OF initialization support
>   zynq: Add OF ram initialization support
>   serial: zynq: Add OF initialization support
> 
>  arch/arm/cpu/armv7/zynq/slcr.c             |   6 +
>  arch/arm/include/asm/arch-zynq/gpio.h      |  25 ++
>  arch/arm/include/asm/arch-zynq/hardware.h  |   2 +
>  arch/arm/include/asm/arch-zynq/sys_proto.h |   2 +
>  board/xilinx/dts/zynq-generic.dts          | 421 +++++++++++++++++++++++++++++
>  board/xilinx/zynq/board.c                  |  75 +++--
>  doc/README.zynq                            |  76 ++++++
>  drivers/mmc/zynq_sdhci.c                   |  29 ++
>  drivers/net/xilinx_emaclite.c              |  15 +-
>  drivers/net/zynq_gem.c                     |  42 +++
>  drivers/serial/serial_zynq.c               |  62 ++++-
>  include/configs/zynq.h                     | 203 +++++++++-----
>  include/netdev.h                           |   2 +
>  13 files changed, 850 insertions(+), 110 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-zynq/gpio.h
>  create mode 100644 board/xilinx/dts/zynq-generic.dts
>  create mode 100644 doc/README.zynq
> 
> --
> 1.8.2.3
> 



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
