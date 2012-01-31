From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:51:18 +0100
Subject: [PATCH v2] mtd/gpmi : add BBT support to gpmi nand driver
In-Reply-To: <1328006303-26844-1-git-send-email-b32955@freescale.com>
References: <1328006303-26844-1-git-send-email-b32955@freescale.com>
Message-ID: <20120131105118.GK2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 06:38:23PM +0800, Huang Shijie wrote:
> Add a new field to gpmi_nand_platform_data{}.
> Make the BBT support to board specific.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Much better :)

> @@ -64,5 +65,6 @@ struct gpmi_nand_platform_data {
>  	/* Medium information. */
>  	struct		mtd_partition *partitions;
>  	unsigned	partition_count;
> +	int		enable_bbt;

Bitfield? (check imx for example)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/372991b5/attachment.sig>
