From: B19295@freescale.com (Lin Tony-B19295)
Date: Fri, 5 Aug 2011 07:53:21 +0000
Subject: [PATCH v4 0/7] ARM: mx28: add usb host function
In-Reply-To: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
References: <1312274386-6833-1-git-send-email-tony.lin@freescale.com>
Message-ID: <97D3A72708D04647A5AC84A04996E5B516A392@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments for the patch series?

Tony

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Tony Lin
> Sent: Tuesday, August 02, 2011 4:40 PM
> To: linux-usb at vger.kernel.org
> Cc: s.hauer at pengutronix.de; stern at rowland.harvard.edu; linux-arm-
> kernel at lists.infradead.org
> Subject: [PATCH v4 0/7] ARM: mx28: add usb host function
> 
> this patch series is to add mx28 usb host function.
> the driver only support usb host mode on usb port1.
> the driver reuses ehci-mxc.c under usb/host, but add platform irq handler
> routines if platform wants to do something specific in irq handler.
> the patch also consolidates some macro definitions and structure
> definitions to make ehci-mxc.c better reusable among mxs/mxc platforms.
> 
> Code is based on the branch for-next in sascha's tree
> http://git.pengutronix.de/git/imx/linux-2.6.git
> 
> Tested on MX28 EVK.
> 
> changes since v3:
>  * change code to standard framework.
>  * avoid changing pdata in driver.
>  * pass testing usb0/usb1 on MX28 EVK board.
> 
> changes since v2:
>  * add error condition clean up code.
>  * remove unnecessary initial code.
>  * change file name from regs-usbphy-mx28 to regs-usbphy-mxs.h.
> 
> changes since v1:
>  * add dummy clock to avoid adding cpu judgement in driver for Sascha's
> request.
>  * use context in phy functions, so that usb device could share the code.
>  * some code consolidation and patch reorgnization.
>  * error checking improvement.
>  * remove a few unneccesary code.
> Tony Lin (7):
>   ARM: mxs: ehci: consolidate definitions and structures to share among
> platforms
>   ARM: mxs: make ehci-mxc more flexible to be used on different platforms
>   ARM: mxs: add usb clocks to clock tree
>   ARM: mxs: enable usb phy power supply
>   ARM: mxs: add usb platform operations
>   ARM: mxs: add usb platform operations
>   ARM:  mxs: add usb host function to default config
> 
>  arch/arm/configs/mxs_defconfig                  |    8 +-
>  arch/arm/mach-mxs/Kconfig                       |    2 +
>  arch/arm/mach-mxs/Makefile                      |    2 +-
>  arch/arm/mach-mxs/clock-mx28.c                  |   25 +++-
>  arch/arm/mach-mxs/devices-mx28.h                |    4 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-usb.c        |   96 +++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |   18 ++
>  arch/arm/mach-mxs/include/mach/hardware.h       |    2 +
>  arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
>  arch/arm/mach-mxs/include/mach/mxs.h            |   12 +-
>  arch/arm/mach-mxs/mach-mx28evk.c                |   20 ++-
>  arch/arm/mach-mxs/regs-usbphy-mxs.h             |  240
> +++++++++++++++++++++++
>  arch/arm/mach-mxs/usbh.c                        |  182 +++++++++++++++++
>  arch/arm/mach-mxs/usbh.h                        |   13 ++
>  arch/arm/plat-mxc/include/mach/mxc_ehci.h       |   19 --
>  drivers/usb/host/Kconfig                        |    2 +-
>  drivers/usb/host/ehci-mxc.c                     |   17 ++-
>  include/linux/fsl_devices.h                     |   21 ++
>  20 files changed, 661 insertions(+), 34 deletions(-)  create mode 100644
> arch/arm/mach-mxs/devices/platform-usb.c
>  create mode 100644 arch/arm/mach-mxs/regs-usbphy-mxs.h
>  create mode 100644 arch/arm/mach-mxs/usbh.c  create mode 100644
> arch/arm/mach-mxs/usbh.h
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
