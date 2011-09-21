From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 21 Sep 2011 13:32:39 +0200
Subject: [PATCH v2 3/3] net/fec: add imx6q enet support
In-Reply-To: <1316603432-20032-4-git-send-email-shawn.guo@linaro.org>
References: <1316603432-20032-1-git-send-email-shawn.guo@linaro.org>
	<1316603432-20032-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110921113239.GF1966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +/* Controller has GBIT support */
> +#define FEC_QUIRK_HAS_GBIT		(1 << 3)

Heh, this is not really a quirk, but a nice feature :) I think we can
drop QUIRK if we see driver_data more as "flags" instead of "quirks"?
Minor, though.

>  MODULE_DEVICE_TABLE(of, fec_dt_ids);
> @@ -373,6 +383,7 @@ fec_restart(struct net_device *ndev, int duplex)
>  	int i;
>  	u32 temp_mac[2];
>  	u32 rcntl = OPT_FRAME_SIZE | 0x04;
> +	u32 ecntl = 0x2; /* ETHEREN */

Also minor, but the patch looks like a good oportunity to start
replacing magic values with proper defines?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110921/1d03569b/attachment.sig>
