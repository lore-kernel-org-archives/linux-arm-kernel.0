From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 2 Sep 2015 10:47:03 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20150812094834.0b0b2af1@canb.auug.org.au>
References: <20150812094834.0b0b2af1@canb.auug.org.au>
Message-ID: <20150902104703.71cbd2ec@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, 12 Aug 2015 09:48:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the arm-soc tree got a conflict in:
> 
>   arch/arm/kernel/psci.c
> 
> between commit:
> 
>   be120397e770 ("ARM: migrate to common PSCI client code")
> 
> from the arm tree and commit:
> 
>   19c233b79d1a ("ARM: appropriate __init annotation for const data")
> 
> from the arm-soc tree.
> 
> I fixed it up (the former removed the file, so I did that, then added
> the following patch) and can carry the fix as necessary (no action
> is required).

These fixups are now being applied to the merge of the arm tree as the
arm-soc commit above has been merged into Linus' tree.

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 12 Aug 2015 09:39:15 +1000
> Subject: [PATCH] ARM: fix for PSCI code movement
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/firmware/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index a6956007dd38..42700f09a8c5 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -337,7 +337,7 @@ out_put_node:
>  	return err;
>  }
>  
> -static const struct of_device_id psci_of_match[] __initconst = {
> +static const struct of_device_id const psci_of_match[] __initconst = {
>  	{ .compatible = "arm,psci",	.data = psci_0_1_init},
>  	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
>  	{},
> -- 
> 2.5.0

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
