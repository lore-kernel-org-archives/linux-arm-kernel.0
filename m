From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Aug 2016 13:00:13 +0100
Subject: [PATCH 1/8] mfd: ucb1x00: allow IRQ probing to work with IRQs > 32
In-Reply-To: <E1begmH-0007Hx-Ky@rmk-PC.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
 <E1begmH-0007Hx-Ky@rmk-PC.armlinux.org.uk>
Message-ID: <20160830120013.GF10121@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2016, Russell King wrote:

> probe_irq_on() only returns non-zero if it found any interrupts below
> IRQ32 which could be probe candidates.  If all the probable interrupts
> are higher than 32, then this will cause a failure.  Fix this.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/mfd/ucb1x00-core.c | 4 ----
>  1 file changed, 4 deletions(-)

Sounds reasonable.  Will fix the $SUBJECT line for you.

Applied, thanks.

> diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
> index 9ab9ec47ea75..48bea5038654 100644
> --- a/drivers/mfd/ucb1x00-core.c
> +++ b/drivers/mfd/ucb1x00-core.c
> @@ -446,10 +446,6 @@ static int ucb1x00_detect_irq(struct ucb1x00 *ucb)
>  	unsigned long mask;
>  
>  	mask = probe_irq_on();
> -	if (!mask) {
> -		probe_irq_off(mask);
> -		return NO_IRQ;
> -	}
>  
>  	/*
>  	 * Enable the ADC interrupt.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
