From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Jan 2015 11:37:40 -0600
Subject: [PATCH 2/5] mfd: tps65218: make INT1 our status_base register
In-Reply-To: <1419622104-25812-3-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-3-git-send-email-balbi@ti.com>
Message-ID: <20150106173740.GM6502@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 26, 2014 at 01:28:21PM -0600, Felipe Balbi wrote:
> If we don't tell regmap-irq that our first status
> register is at offset 1, it will try to read offset
> zero, which is the chipid register.
> 
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

ping

> ---
>  drivers/mfd/tps65218.c | 1 +
>  1 file changed, 1 insertion(+)
> 
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
> -- 
> 2.2.0
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/1074b56b/attachment-0001.sig>
