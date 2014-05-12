From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 May 2014 22:09:34 +0800
Subject: [PATCH] media: mx1_camera: Remove driver
In-Reply-To: <1399788551-8218-1-git-send-email-shc_work@mail.ru>
References: <1399788551-8218-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140512140933.GC8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 10:09:11AM +0400, Alexander Shiyan wrote:
> That driver hasn't been really maintained for a long time. It doesn't
> compile in any way, it includes non-existent headers, has no users,
> and marked as "broken" more than year. Due to these factors, mx1_camera
> is now removed from the tree.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/Makefile                      |   3 -
>  arch/arm/mach-imx/devices/Kconfig               |   3 -
>  arch/arm/mach-imx/devices/Makefile              |   1 -
>  arch/arm/mach-imx/devices/devices-common.h      |  10 -
>  arch/arm/mach-imx/devices/platform-mx1-camera.c |  42 --
>  arch/arm/mach-imx/mx1-camera-fiq-ksym.c         |  18 -
>  arch/arm/mach-imx/mx1-camera-fiq.S              |  35 -
>  drivers/media/platform/soc_camera/Kconfig       |  13 -
>  drivers/media/platform/soc_camera/Makefile      |   1 -
>  drivers/media/platform/soc_camera/mx1_camera.c  | 866 ------------------------
>  include/linux/platform_data/camera-mx1.h        |  35 -
>  11 files changed, 1027 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/devices/platform-mx1-camera.c
>  delete mode 100644 arch/arm/mach-imx/mx1-camera-fiq-ksym.c
>  delete mode 100644 arch/arm/mach-imx/mx1-camera-fiq.S
>  delete mode 100644 drivers/media/platform/soc_camera/mx1_camera.c
>  delete mode 100644 include/linux/platform_data/camera-mx1.h

Can this patch be split into arch and driver part?  Recently, arm-soc
folks do not want to have arch changes go via driver tree, unless that's
absolutely necessary.

Shawn
