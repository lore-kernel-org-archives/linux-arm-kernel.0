From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Aug 2016 09:29:33 +0100
Subject: [RESEND v2 05/10] mfd: stmpe: use generic bit mask name
In-Reply-To: <1470814755-19447-6-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
 <1470814755-19447-6-git-send-email-patrice.chotard@st.com>
Message-ID: <20160810082933.GK1581@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2016, patrice.chotard at st.com wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
> 
> In order to prepare the ground to STMPE1600,
> as STMPE1600's SYS_CTRL register has the same layout as
> STMPE801 variant, unify STMPExxx_REG_SYS_CTRL_RESET/INT_EN/INT_HI
> bit masks to more generic STMPE_SYS_CTRL_RESET/INT_EN/INT_HI
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/stmpe.c | 4 ++--
>  drivers/mfd/stmpe.h | 6 ++----
>  2 files changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index af682d0..2556463 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -1089,7 +1089,7 @@ static int stmpe_chip_init(struct stmpe *stmpe)
>  
>  	if (stmpe->irq >= 0) {
>  		if (id == STMPE801_ID)
> -			icr = STMPE801_REG_SYS_CTRL_INT_EN;
> +			icr = STMPE_SYS_CTRL_INT_EN;
>  		else
>  			icr = STMPE_ICR_LSB_GIM;
>  
> @@ -1103,7 +1103,7 @@ static int stmpe_chip_init(struct stmpe *stmpe)
>  		if (irq_trigger == IRQF_TRIGGER_RISING ||
>  				irq_trigger == IRQF_TRIGGER_HIGH) {
>  			if (id == STMPE801_ID)
> -				icr |= STMPE801_REG_SYS_CTRL_INT_HI;
> +				icr |= STMPE_SYS_CTRL_INT_HI;
>  			else
>  				icr |= STMPE_ICR_LSB_HIGH;
>  		}
> diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
> index 4ae343d..4ba1123 100644
> --- a/drivers/mfd/stmpe.h
> +++ b/drivers/mfd/stmpe.h
> @@ -105,6 +105,8 @@ int stmpe_remove(struct stmpe *stmpe);
>  #define STMPE_ICR_LSB_GIM	(1 << 0)
>  
>  #define STMPE_SYS_CTRL_RESET	(1 << 7)
> +#define STMPE_SYS_CTRL_INT_EN	(1 << 2)
> +#define STMPE_SYS_CTRL_INT_HI	(1 << 0)
>  
>  /*
>   * STMPE801
> @@ -121,10 +123,6 @@ int stmpe_remove(struct stmpe *stmpe);
>  #define STMPE801_REG_GPIO_SET_PIN	0x11
>  #define STMPE801_REG_GPIO_DIR		0x12
>  
> -#define STMPE801_REG_SYS_CTRL_RESET	(1 << 7)
> -#define STMPE801_REG_SYS_CTRL_INT_EN	(1 << 2)
> -#define STMPE801_REG_SYS_CTRL_INT_HI	(1 << 0)
> -
>  /*
>   * STMPE811
>   */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
