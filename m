From: mbizon@freebox.fr (Maxime Bizon)
Date: Sat, 14 Aug 2010 00:28:00 +0200
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <1275827336-31111-2-git-send-email-saeed@marvell.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
Message-ID: <1281738480.12446.533.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sun, 2010-06-06 at 15:28 +0300, Saeed Bishara wrote:

> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 4ccfdf9..c4bd8cb 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -114,6 +114,7 @@ void __init kirkwood_ehci_init(void)
>   ****************************************************************************/
>  struct mv643xx_eth_shared_platform_data kirkwood_ge00_shared_data = {
>  	.dram		= &kirkwood_mbus_dram_info,
> +	.tx_csum_limit	= 1600,
>  };
>  
>  static struct resource kirkwood_ge00_shared_resources[] = {

Kirkwood (at least) has a second ethernet mac, please add the definition
for it too.

Thanks,

-- 
Maxime
