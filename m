From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:56:12 +0530
Subject: [PATCH v5 13/22] gpio/omap: cleanup omap_gpio_mod_init function
In-Reply-To: <1312455893-14922-14-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-14-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53AA74.5090906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. This function now has common initialization code for
> all OMAP versions. Initialization specific to OMAP16xx has been moved within
> omap16xx_gpio_init().
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap1/gpio16xx.c |   34 ++++++++++++++++++-
>   drivers/gpio/gpio-omap.c       |   71 +++++++++++-----------------------------
>   2 files changed, 52 insertions(+), 53 deletions(-)
>

[...]

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 21cb0d4..f6855e5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c

[...]

> @@ -1074,6 +1036,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>   	pm_runtime_enable(bank->dev);
>   	pm_runtime_get_sync(bank->dev);
>
> +	if (bank_is_mpuio(bank)) {
> +		if (bank->regs->wkup_status)
> +			mpuio_init(bank);
The above check looks strange. What are you trying here ?

Regards
Santosh
