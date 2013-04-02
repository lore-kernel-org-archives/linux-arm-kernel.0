From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Apr 2013 15:27:28 +0530
Subject: [PATCH v7 0/5] Add DT support for davinci_mmc driver
In-Reply-To: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
References: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Message-ID: <515AAB88.3030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 3/28/2013 6:40 PM, Manjunathappa, Prakash wrote:
> Patch set adds DT support for davinci_mmc driver and is
> verified on da850-evm without card_detect/write_protect and
> EDMA support. Also takecare to derive controller IP version from
> platform_device_id table, remove version specification in pdata.

> Manjunathappa, Prakash (5):
>   mmc: davinci: allow driver to work without DMA resource
>   ARM: davinci: mmc: derive version information from device name
>   mmc: davinci_mmc: add DT support
>   ARM: davinci: da850: add mmc DT entries
>   ARM: davinci: da850: override mmc DT node device name
> 
>  .../devicetree/bindings/mmc/davinci_mmc.txt        |   33 +++++++
>  arch/arm/boot/dts/da850-evm.dts                    |    7 ++
>  arch/arm/boot/dts/da850.dtsi                       |   15 +++
>  arch/arm/mach-davinci/board-da830-evm.c            |    1 -
>  arch/arm/mach-davinci/board-da850-evm.c            |    2 -
>  arch/arm/mach-davinci/board-dm355-evm.c            |    1 -
>  arch/arm/mach-davinci/board-dm365-evm.c            |    1 -
>  arch/arm/mach-davinci/board-dm644x-evm.c           |    1 -
>  arch/arm/mach-davinci/board-neuros-osd2.c          |    1 -
>  arch/arm/mach-davinci/board-omapl138-hawk.c        |    1 -
>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    1 -
>  arch/arm/mach-davinci/da830.c                      |    2 +-
>  arch/arm/mach-davinci/da850.c                      |    4 +-
>  arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
>  arch/arm/mach-davinci/devices-da8xx.c              |    4 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c          |    4 +-
>  arch/arm/mach-davinci/devices.c                    |    6 +-
>  arch/arm/mach-davinci/dm355.c                      |    4 +-
>  arch/arm/mach-davinci/dm365.c                      |    4 +-
>  arch/arm/mach-davinci/dm644x.c                     |    2 +-
>  arch/arm/mach-davinci/tnetv107x.c                  |    4 +-
>  drivers/mmc/host/davinci_mmc.c                     |   98 ++++++++++++++++++--
>  include/linux/platform_data/mmc-davinci.h          |    3 -
>  23 files changed, 163 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

I would like to take this series through DaVinci tree to manage the
dependencies with mach-davinci. I need your ack on the driver part and
the DT binding. Can you please provide your ack?

Thanks,
Sekhar
