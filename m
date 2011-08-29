From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 29 Aug 2011 10:36:49 +0200
Subject: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
Message-ID: <20110829083649.GB24524@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
> 
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
>  drivers/ata/ahci_platform.c |   44 +++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 6fef1fa..f32c91e 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -23,6 +23,41 @@
>  #include <linux/ahci_platform.h>
>  #include "ahci.h"
>  
> +enum ahci_type {
> +	AHCI,		/* standard platform ahci */
> +	IMX53_AHCI,	/* ahci on i.mx53 */

How about making all the IMX*-naming more generic because other SoC might need
this somewhen, too?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110829/c99bf92a/attachment.sig>
