From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jun 2015 10:16:35 +0100
Subject: [PATCH 10/11] spi: add more debug prints in s3c64xx
In-Reply-To: <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
Message-ID: <20150604091634.GY14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 09:26:42PM -0000, Michal Suchanek wrote:
> The SPI NOR transfers mysteriously fail so add more debug prints about
> SPI transactions.

Please try to only send patches to relevant people - the list of
recipients for this is so large that it only barely fits on a single
screen in my mail client.

Also for this patch (which just adds some trace) there isn't any clear
reason for it to be sent as part of the series at all, it doesn't help
deliver the functionality and doesn't depend on the rest of the series.

> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>

Whatever you're doing here this indicates that there's a very big
abstraction problem going on.

> +	pr_debug("%s %s %s waiting for %ims transferring %zubytes@%iHz",
> +		 __func__, sdd->pdev ? dev_name(&sdd->pdev->dev) : NULL,
> +		 dev_name(&sdd->master->dev),
> +		 ms, xfer->len, sdd->cur_speed);

I'd say dev_dbg() but more generally this is just tracing things that
seem to be already covered by the trace points already present in the
core, the same goes for most of the rest of it.  If there's things
missing from the existing trace it seems better to add to it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/bcd71d7d/attachment.sig>
