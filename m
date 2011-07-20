From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Jul 2011 13:57:43 +0300
Subject: [PATCH 0/7] ARM: mx28: add usb host function
In-Reply-To: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
Message-ID: <20110720105742.GI764@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 20, 2011 at 07:08:19PM +0800, Tony Lin wrote:
> this patch series is to add mx28 usb host function.
> the driver only support usb host mode on usb port1.
> the driver reuses ehci-mxc.c under usb/host, but did
> some modifications based on it to satisfy mx28 usb host
> requirement. The modifications will not affect other
> platforms.
> 
> Code is based on the branch for-next in sascha's tree
> http://git.pengutronix.de/git/imx/linux-2.6.git
> 
> Tested on MX28 EVK.
> 
> Tony Lin (7):
>   consolidate definitions and structures to share among platforms
>   enable usb1 phy power supply
>   add usb phy clocks to clock tree
>   mx28: add usb host phy functions
>   ehci mxc: make it more flexible to be used for mx28
>   add macro definitions according to ehci-mxc driver change
>   add usb host function to default config
> 
>  arch/arm/configs/mxs_defconfig            |    8 +-
>  arch/arm/mach-mxs/Kconfig                 |    1 +
>  arch/arm/mach-mxs/Makefile                |    1 +
>  arch/arm/mach-mxs/clock-mx28.c            |   18 ++
>  arch/arm/mach-mxs/include/mach/hardware.h |    2 +
>  arch/arm/mach-mxs/include/mach/mxs.h      |   12 +-
>  arch/arm/mach-mxs/mach-mx28evk.c          |    9 +
>  arch/arm/mach-mxs/regs-usbphy-mx28.h      |  323 +++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/usb_h1.c                |  230 ++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mxc.h      |    3 +
>  arch/arm/plat-mxc/include/mach/mxc_ehci.h |   19 --
>  drivers/usb/host/Kconfig                  |    2 +-
>  drivers/usb/host/ehci-mxc.c               |   57 ++++--
>  include/linux/fsl_devices.h               |   21 ++
>  14 files changed, 669 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/regs-usbphy-mx28.h
>  create mode 100644 arch/arm/mach-mxs/usb_h1.c

Alan Stern is the maintainer for the EHCI driver. I'll have a look on
this series anyway ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/c9e77787/attachment.sig>
