From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Dec 2013 07:38:57 +0000
Subject: [PATCH 3/3] ARM: ux500: regulators: Remove dead code for SD-card
 regulator
In-Reply-To: <1386855098-14272-4-git-send-email-ulf.hansson@linaro.org>
References: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
 <1386855098-14272-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20131213073857.GB8819@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Dec 2013, Ulf Hansson wrote:

> The signal-voltage regulator is handled through a gpio regulator
> configured in DT. Remove the old dead code.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500-regulators.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
> index 0dc44c6..a4e139a 100644
> --- a/arch/arm/mach-ux500/board-mop500-regulators.c
> +++ b/arch/arm/mach-ux500/board-mop500-regulators.c
> @@ -30,20 +30,6 @@ struct regulator_init_data gpio_en_3v3_regulator = {
>         .consumer_supplies = gpio_en_3v3_consumers,
>  };
>  
> -static struct regulator_consumer_supply sdi0_reg_consumers[] = {
> -        REGULATOR_SUPPLY("vqmmc", "sdi0"),
> -};
> -
> -struct regulator_init_data sdi0_reg_init_data = {

You also need to remove it from the header file:

  arch/arm/mach-ux500/board-mop500-regulators.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
