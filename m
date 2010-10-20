From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 20 Oct 2010 12:24:13 +0200
Subject: [PATCH 1/2] Add the GPIO Write Protection Solution on i.MX51
	BBG board
In-Reply-To: <1287568828-22563-2-git-send-email-r65037@freescale.com>
References: <1287568828-22563-1-git-send-email-r65037@freescale.com>
	<1287568828-22563-2-git-send-email-r65037@freescale.com>
Message-ID: <20101020102413.GE2691@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Wed, Oct 20, 2010 at 06:00:27PM +0800, Richard Zhu wrote:
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c      |   16 ++++++++++++++--
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |    8 +++++---
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 476bfe4..5a69cda 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -34,6 +34,8 @@
>  #include "devices-imx51.h"
>  #include "devices.h"
>  
> +#define BABBAGE_SDHCI1_WP	(0*32 + 1)	/* GPIO_1_1 */
> +#define BABBAGE_SDHCI2_WP	(0*32 + 5)	/* GPIO_1_5 */

Please mention in the subject of this patch that this "write protection" is 
related to the SDHCI device.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
