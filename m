From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 11 Jan 2010 14:07:10 +1300
Subject: [PATCH] ep93xx: use pr_fmt in dma-m2p.c
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F63A@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F63A@mi8nycmail19.Mi8.com>
Message-ID: <4B4A79BE.6080302@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Use pr_fmt to prefix kernel output with the module name.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/dma-m2p.c b/arch/arm/mach-ep93xx/dma-m2p.c
> index dbcac9c..8904ca4 100644
> --- a/arch/arm/mach-ep93xx/dma-m2p.c
> +++ b/arch/arm/mach-ep93xx/dma-m2p.c
> @@ -28,6 +28,8 @@
>   * with this implementation.
>   */
>  
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -173,7 +175,7 @@ static irqreturn_t m2p_irq(int irq, void *dev_id)
>  
>  	switch (m2p_channel_state(ch)) {
>  	case STATE_IDLE:
> -		pr_crit("m2p_irq: dma interrupt without a dma buffer\n");
> +		pr_crit("dma interrupt without a dma buffer\n");
>  		BUG();
>  		break;
>  
> @@ -197,7 +199,7 @@ static irqreturn_t m2p_irq(int irq, void *dev_id)
>  		break;
>  
>  	case STATE_NEXT:
> -		pr_crit("m2p_irq: dma interrupt while next\n");
> +		pr_crit("dma interrupt while next\n");
>  		BUG();
>  		break;
>  	} 

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
