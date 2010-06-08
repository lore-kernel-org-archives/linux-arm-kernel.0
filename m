From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 8 Jun 2010 19:09:48 +0200
Subject: [PATCH 2/2] set packet size limit for the mv643xx csum offloading
In-Reply-To: <1275827336-31111-2-git-send-email-saeed@marvell.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<1275827336-31111-2-git-send-email-saeed@marvell.com>
Message-ID: <20100608170948.GS1743@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 06, 2010 at 03:28:56PM +0300, Saeed Bishara wrote:

> The mv643xx ethernet controller limits the packet size for the TX
> checksum offloading. this patch sets this limits for the needed
> devices.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  arch/arm/mach-dove/common.c     |    1 +
>  arch/arm/mach-kirkwood/common.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 5da2cf4..473ce0b 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -149,6 +149,7 @@ void __init dove_ehci1_init(void)
>  struct mv643xx_eth_shared_platform_data dove_ge00_shared_data = {
>  	.t_clk		= 0,
>  	.dram		= &dove_mbus_dram_info,
> +	.tx_csum_limit	= 1600,

Assuming that 1600 is exactly the right value (and not 1599 or 1601 etc),

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>

Can you fill in for orion5x/dd/loki as well?
