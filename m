From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Thu, 21 May 2015 01:45:01 +0200
Subject: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
In-Reply-To: <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <555D1C7D.1060205@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
> The STM32 MCUs family IPs can be reset by accessing some registers
> from the RCC block.
> 
> The list of available reset lines is documented in the DT bindings.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-stm32.c | 124 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 drivers/reset/reset-stm32.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 157d421..aed12d1 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_RESET_CONTROLLER) += core.o
>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_ARCH_STI) += sti/
> diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
> new file mode 100644
> index 0000000..2c41858
> --- /dev/null
> +++ b/drivers/reset/reset-stm32.c
[...]
> +static const struct of_device_id stm32_reset_dt_ids[] = {
> +	 { .compatible = "st,stm32-rcc", },
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);

Typo.

IIUC the timer depends on the reset controller, so it must be built in
anyway, and that's what's enforced in the Makefile above. Drop the line?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
