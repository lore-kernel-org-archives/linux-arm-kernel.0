From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Feb 2014 16:41:32 -0800
Subject: [PATCH v6 0/8] ARM: brcmstb: Add Broadcom STB SoC support
In-Reply-To: <1391463041-15241-1-git-send-email-marc.ceeeee@gmail.com>
References: <1391463041-15241-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <CAGVrzcZTHZYaB7sEDxFrP3PzZh0y-daS0gqg2Z4PUzuWGFeiSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

2014-02-03 13:30 GMT-08:00 Marc Carino <marc.ceeeee@gmail.com>:
> This patchset contains the board support package for the
> Broadcom BCM7445 ARM-based SoC [1]. These changes contain a
> minimal set of code needed for a BCM7445-based board to boot
> the Linux kernel.

If you are happy with this round of changes, can you also carry those
patches in your tree for 3.15?

>
> These changes heavily leverage the OF/devicetree framework.
>
> v6:
> - rebased to v3.14-rc1
> - utilize common APIs for handling CPU power-down
> - drop deprecated __cpuinit attributes
>
> v5 (https://lkml.org/lkml/2014/1/21/640):
> - rebased to v3.13 tag
> - make UART DT node a child of 'rdb' node
> - fix ordering of debug UART entries
>
> v4 (https://lkml.org/lkml/2014/1/17/455):
> - make a reboot driver and put it in the drivers folder
> - rework DT bindings to leverage 'syscon'
> - rework BSP code to use 'syscon' for all register mappings
> - misc. tweaks per suggestions from v3
>
> v3 (https://lkml.org/lkml/2014/1/14/696):
> - rebased to v3.13-rc8
> - switched to using 'multi_v7_defconfig'
> - eliminated dependence on compile-time peripheral register access
> - moved DT node iomap out from 'init_early'
> - misc. minor cleanups from mailing-list discussion for v2
>
> v2 (https://lkml.org/lkml/2013/11/26/570):
> - rebased to v3.13-rc1
> - moved implementation to 'mach-bcm' folder
> - added CPU init for B16RM
>
> v1:
> - initial submission
>
> [1] http://www.broadcom.com/products/Cable/Cable-Set-Top-Box-Solutions/BCM7445
>
> Marc Carino (8):
>   ARM: brcmstb: add infrastructure for ARM-based Broadcom STB SoCs
>   power: reset: Add reboot driver for brcmstb
>   ARM: brcmstb: add debug UART for earlyprintk support
>   ARM: do CPU-specific init for Broadcom Brahma15 cores
>   ARM: brcmstb: add CPU binding for Broadcom Brahma15
>   ARM: brcmstb: add misc. DT bindings for brcmstb
>   ARM: brcmstb: gic: add compatible string for Broadcom Brahma15
>   ARM: brcmstb: dts: add a reference DTS for Broadcom 7445
>
>  .../devicetree/bindings/arm/brcm-brcmstb.txt       |   95 ++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
>  Documentation/devicetree/bindings/arm/gic.txt      |    1 +
>  arch/arm/Kconfig.debug                             |   15 +-
>  arch/arm/boot/dts/bcm7445.dts                      |  111 +++++++
>  arch/arm/configs/multi_v7_defconfig                |    1 +
>  arch/arm/mach-bcm/Kconfig                          |   15 +
>  arch/arm/mach-bcm/Makefile                         |    4 +
>  arch/arm/mach-bcm/brcmstb.c                        |  104 +++++++
>  arch/arm/mach-bcm/brcmstb.h                        |   38 +++
>  arch/arm/mach-bcm/headsmp-brcmstb.S                |   33 ++
>  arch/arm/mach-bcm/hotplug-brcmstb.c                |  311 ++++++++++++++++++++
>  arch/arm/mm/proc-v7.S                              |   11 +
>  drivers/power/reset/Kconfig                        |   10 +
>  drivers/power/reset/Makefile                       |    1 +
>  drivers/power/reset/brcmstb-reboot.c               |  120 ++++++++
>  16 files changed, 870 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
>  create mode 100644 arch/arm/boot/dts/bcm7445.dts
>  create mode 100644 arch/arm/mach-bcm/brcmstb.c
>  create mode 100644 arch/arm/mach-bcm/brcmstb.h
>  create mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
>  create mode 100644 arch/arm/mach-bcm/hotplug-brcmstb.c
>  create mode 100644 drivers/power/reset/brcmstb-reboot.c
>



-- 
Florian
