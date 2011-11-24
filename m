From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 20:59:53 +0800
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
Message-ID: <20111124125952.GD18060@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 12:49:54PM +0100, Peter Rusko wrote:
> This patch is based on the Freescale SDK 2010.08. It supports the on-chip
> Low Resolution ADC and a capacitive touchscreen connected to it.
> 
> Tested on Ka-Ro TX28 module
> 
> Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
> ---
>  arch/arm/mach-mxs/devices-mx28.h                |    6 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-mxs-lradc.c  |   25 +
>  arch/arm/mach-mxs/devices/platform-mxs-ts.c     |   34 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |   22 +
>  arch/arm/mach-mxs/include/mach/lradc.h          |   61 ++
>  arch/arm/mach-mxs/include/mach/mx28.h           |    4 +-
>  arch/arm/mach-mxs/include/mach/regs-lradc.h     |  772 +++++++++++++++++++++++
>  drivers/input/touchscreen/Kconfig               |   11 +
>  drivers/input/touchscreen/Makefile              |    1 +
>  drivers/input/touchscreen/mxs_ts.c              |  470 ++++++++++++++
>  drivers/misc/Kconfig                            |    3 +
>  drivers/misc/Makefile                           |    1 +
>  drivers/misc/mxs_lradc.c                        |  381 +++++++++++
>  15 files changed, 1793 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-lradc.c
>  create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-ts.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/lradc.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/regs-lradc.h
>  create mode 100644 drivers/input/touchscreen/mxs_ts.c
>  create mode 100644 drivers/misc/mxs_lradc.c
> 
I think this patch should probably be split into 4.

 * lradc drivers/staging/iio/adc/ (rather than drivers/misc/) part
 * lradc arch/arm/mach-mxs part
 * touchscreen drivers/input/touchscreen part
 * touchscreen arch/arm/mach-mxs part

And you need to look into MAINTAINERS for the mailing list and people
that the 'drivers' part should be sent to.

-- 
Regards,
Shawn
