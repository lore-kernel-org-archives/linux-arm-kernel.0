From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 20 May 2014 11:18:11 +0200
Subject: [PATCH v4 4/7] ata: ahci_platform: add the Marvell Berlin AHCI
 compatible
In-Reply-To: <1400576675-25265-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <537B1DD3.2040104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2014 11:04 AM, Antoine T?nart wrote:
> The Marvell Berlin AHCI has all his specific in the PHY driver. It then
> only need to use the libahci functions to work properly.

If it is that generic, ..

> Add its compatible into the libahci_platform driver.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   drivers/ata/ahci_platform.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index ef67e79944f9..bc050aabf206 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -76,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
>   	{ .compatible = "snps,exynos5440-ahci", },
>   	{ .compatible = "ibm,476gtr-ahci", },
>   	{ .compatible = "snps,dwc-ahci", },
> +	{ .compatible = "marvell,berlin-ahci", },

.. why have a Marvell-specific compatible?

How about "generic-ahci" instead, like we have for other fooHCIs
already?

Sebastian

>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
>
