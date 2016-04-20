From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 20 Apr 2016 11:11:44 +0100
Subject: [PATCH RESEND] drivers: firmware: psci: drop duplicate const
 from psci_of_match
In-Reply-To: <1458657946-2616-1-git-send-email-jszhang@marvell.com>
References: <1458657946-2616-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160420101144.GA22530@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 10:45:46PM +0800, Jisheng Zhang wrote:
> This is to fix below sparse warning:
> drivers/firmware/psci.c:mmm:nn: warning: duplicate const
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/firmware/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I am sending it to arm-soc to merge it.

Thanks,
Lorenzo

> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index d24f35d..ae70d24 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -424,7 +424,7 @@ out_put_node:
>  	return err;
>  }
>  
> -static const struct of_device_id const psci_of_match[] __initconst = {
> +static const struct of_device_id psci_of_match[] __initconst = {
>  	{ .compatible = "arm,psci",	.data = psci_0_1_init},
>  	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
>  	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
> -- 
> 2.6.2
> 
