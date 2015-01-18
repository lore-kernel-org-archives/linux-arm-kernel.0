From: lee.jones@linaro.org (Lee Jones)
Date: Sun, 18 Jan 2015 09:52:39 +0000
Subject: [PATCH 2/5] mfd: tps65218: make INT1 our status_base register
In-Reply-To: <1419622104-25812-3-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-3-git-send-email-balbi@ti.com>
Message-ID: <20150118095239.GB3574@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Dec 2014, Felipe Balbi wrote:

> If we don't tell regmap-irq that our first status
> register is at offset 1, it will try to read offset
> zero, which is the chipid register.
> 
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/tps65218.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the delay.  It's difficult to get a WiFi signal 2000m up in
an Austrian mountain. :)

Applied now, thanks.

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 2243f75..d6b7643 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -204,6 +204,7 @@ static struct regmap_irq_chip tps65218_irq_chip = {
>  
>  	.num_regs = 2,
>  	.mask_base = TPS65218_REG_INT_MASK1,
> +	.status_base = TPS65218_REG_INT1,
>  };
>  
>  static const struct of_device_id of_tps65218_match_table[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
