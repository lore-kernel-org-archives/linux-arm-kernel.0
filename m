From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Thu, 29 Dec 2016 19:44:32 +0100
Subject: [PATCH 1/6] ARM: mach-mx31_3ds: Remove camera support
In-Reply-To: <1482756987-12414-1-git-send-email-festevam@gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
Message-ID: <CAM=E1R4ExOmqn3YCjS6wVtpCS13=dAPDtT9sgYxcAgc4UreV=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 26 December 2016 at 13:56, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
> mx3 driver") the mx3 camera driver has been removed, so remove the camera
> support from the board file as well.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/mach-imx/mach-mx31_3ds.c | 145 --------------------------------------
>  1 file changed, 145 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index 12b8a52..ada29d0 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -26,16 +26,12 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
> -#include <linux/memblock.h>
> -
> -#include <media/soc_camera.h>
>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <asm/memory.h>
>  #include <asm/mach/map.h>
> -#include <asm/memblock.h>
>
>  #include "3ds_debugboard.h"
>  #include "common.h"
> @@ -152,8 +148,6 @@ static int mx31_3ds_pins[] = {
>         MX31_PIN_CSI_MCLK__CSI_MCLK,
>         MX31_PIN_CSI_PIXCLK__CSI_PIXCLK,
>         MX31_PIN_CSI_VSYNC__CSI_VSYNC,
> -       MX31_PIN_CSI_D5__GPIO3_5, /* CMOS PWDN */
> -       IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_GPIO), /* CMOS reset */

So we keep the init of the other CSI pins bit not the power down and
reset? Can / should the other CSI pins also be removed?

I've run-time tested the patch on the i.MX31 PDK board now and it works.

Regards, Magnus
