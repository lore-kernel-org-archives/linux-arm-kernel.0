From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 May 2016 19:04:14 +0200
Subject: [PATCH v3 0/4] Add Amlogic secure monitor driver
In-Reply-To: <1464021024-29380-1-git-send-email-carlo@caione.org>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
Message-ID: <5743380E.9010402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/05/16 18:30, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> In the Amlogic SoCs the secure monitor calls are used for a lot of reasons:
> interact with the NVMEM (efuses), check the reboot reason, set USB boot, ...
>
> This driver defines a generic interface towards the secure monitor that can be
> used by more specialized drivers to interact with the secure monitor itself
> without worrying about bounce buffers managing.
>

For the whole series:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> Changelog:
>
> v3:
>    * Moved driver to drivers/firmware
>    * Added EXPORT_SYMBOL macros
>    * Changed '_' in '-'
>    * Introduced 'struct meson_sm_firmware' and 'meson_sm_get_fw()' to be used by
>      drivers using the secure-monitor to enforce probe ordering
>
> v2:
>    * All the SMC function identifiers are now in a SoC-specific header file to
>      be included by the DTS files so the SMC commands are now defined in the DT
>      instead to be hardcoded into the driver
>    * Patchset is no longer an RFC
>    * Better error management and boundary checking
>    * s/unsigned int/u32/
>    * SMC call not only on CPU 0
>    * Fix memory leaking
>    * s/amlogic/meson/ in the directory names
>
>
> Carlo Caione (4):
>    firmware: Amlogic: Add secure monitor driver
>    firmware: dt-bindings: Add secure monitor header file for GXBB
>    ARM64: dts: amlogic: gxbb: Enable secure monitor
>    documentation: Add secure monitor binding documentation
>
>   .../bindings/firmware/meson/meson_sm.txt           |  51 ++++++
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  11 ++
>   drivers/firmware/Kconfig                           |   1 +
>   drivers/firmware/Makefile                          |   1 +
>   drivers/firmware/meson/Kconfig                     |   8 +
>   drivers/firmware/meson/Makefile                    |   1 +
>   drivers/firmware/meson/meson_sm.c                  | 179 +++++++++++++++++++++
>   include/dt-bindings/firmware/meson-gxbb-sm.h       |  44 +++++
>   include/linux/firmware/meson/meson_sm.h            |  38 +++++
>   9 files changed, 334 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
>   create mode 100644 drivers/firmware/meson/Kconfig
>   create mode 100644 drivers/firmware/meson/Makefile
>   create mode 100644 drivers/firmware/meson/meson_sm.c
>   create mode 100644 include/dt-bindings/firmware/meson-gxbb-sm.h
>   create mode 100644 include/linux/firmware/meson/meson_sm.h
>
