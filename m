From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 10:06:58 +0800
Subject: [PATCH 0/4] Remove Genesi Efika MX support
In-Reply-To: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
References: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
Message-ID: <20120806020656.GA18471@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 12:49:27PM -0500, Matt Sealey wrote:
> In an effort to start afresh we are removing the "legacy" Efika MX support
> from the tree in this patch series so as to break ties with any non-device-tree
> code and minimize the possibility that there are two ways to build for our
> boards.
> 
> Patches to support the board again with FDT (along with a matching U-Boot)
> are not ready for submission, but that doesn't block *this* submission. The
> number of users of 3.5 kernels on Genesi platforms is generally thought of
> as zero and no significant work or support has been committed to the platform
> in a long time. In our opinion, all efforts by external developers wishing to
> run modern kernels on Genesi Efika MX boards should be directed at device tree
> support for the MX51 platforms.
> 
> Matt Sealey (4):
>   efikamx: remove support for Genesi Efika MX from the build
>   efikamx: remove Genesi Efika MX from the i.MX v6/v7 defconfig
>   efikamx: remove Genesi Efika MX platform files from the tree
>   efikamx: remove Efika MX-specific CHRGVBUS hack from the USB driver
> 
>  arch/arm/configs/imx_v6_v7_defconfig  |    2 -
>  arch/arm/mach-imx/Kconfig             |   26 --
>  arch/arm/mach-imx/Makefile            |    3 -
>  arch/arm/mach-imx/efika.h             |   10 -
>  arch/arm/mach-imx/mach-mx51_efikamx.c |  300 ----------------
>  arch/arm/mach-imx/mach-mx51_efikasb.c |  296 ---------------
>  arch/arm/mach-imx/mx51_efika.c        |  632 ---------------------------------
>  drivers/usb/host/ehci-mxc.c           |   20 --
>  8 files changed, 1289 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/efika.h
>  delete mode 100644 arch/arm/mach-imx/mach-mx51_efikamx.c
>  delete mode 100644 arch/arm/mach-imx/mach-mx51_efikasb.c
>  delete mode 100644 arch/arm/mach-imx/mx51_efika.c
> 
I set up a branch imx/rm-boards and queued the series there.  I expect
I will have some patches removing imx53 board files to be queued there
for 3.7 too.

-- 
Regards,
Shawn
