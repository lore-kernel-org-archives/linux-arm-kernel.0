From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 Mar 2011 09:37:24 +0100
Subject: [PATCH V1 1/3] ahci_platform: add two clk pointer member into
	ahci_platform_data struct
In-Reply-To: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110317083724.GV29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 03:10:58PM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  include/linux/ahci_platform.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index be3d9a7..86b5e24 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -26,6 +26,8 @@ struct ahci_platform_data {
>  	const struct ata_port_info *ata_port_info;
>  	unsigned int force_port_map;
>  	unsigned int mask_port_map;
> +	struct clk *sata_clk;
> +	struct clk *sata_ref_clk;

No, ahci_platform_data shouldn't be the dump place for arbitrary board
data. Keep this to your board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
