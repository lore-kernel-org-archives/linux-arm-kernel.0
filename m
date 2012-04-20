From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Apr 2012 14:09:50 +0200
Subject: [PATCH v5] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <1334913755-10466-1-git-send-email-stigge@antcom.de>
References: <1334913755-10466-1-git-send-email-stigge@antcom.de>
Message-ID: <20120420120950.GA15613@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 11:22:35AM +0200, Roland Stigge wrote:
> This patch adds device tree support to the pnx-i2c driver by using platform
> resources for memory region and irq and removing dependency on mach includes.
> 
> The following platforms are affected:
> 
> * PNX
> * LPC31xx (WIP)
> * LPC32xx
> 
> The patch is based on a patch by Jon Smirl, working on lpc31xx integration
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

NACK! I said the approach of dropping "timeout" is OK, but unless I say
"you may add my ack after changing this and that", please do not
automatically add my ack. Doesn't hurt here, since I have to pick it up
anyway.

> Changes since v4:
> * Removed OF timeout property (to be added later when there is consensus about
>   how to call and handle it)
> * Changed clock-frequency example to decimal

Thanks, I just noticed. Please drop (more precise: remove) the
"slave-addr" for the same reasons as "timeout". Doesn't make much sense
anyhow, pnx doesn't have any slave support.

>  	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
> -			0, pdev->name, alg_data);
> +			  0, pdev->name, alg_data);

I know that checkpatch complains about this, but I'd prefer to avoid
such changes unless the code before was really unreadable.

Regards,

    Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/041b8d48/attachment.sig>
