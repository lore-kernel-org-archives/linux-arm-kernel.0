From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 11 May 2016 22:58:14 +0300
Subject: [PATCH] gpio: lpc32xx: disable broken to_irq support
In-Reply-To: <1462988400-21738-1-git-send-email-slemieux.tyco@gmail.com>
References: <1462988400-21738-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <57338ED6.3090001@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 11.05.2016 20:40, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The "to_irq" functionality is broken inside this driver since commit
> 76ba59f8366f ("genirq: Add irq_domain-aware core IRQ handler").
> 
> The addition of the new lpc32xx irqchip driver in 4.7, fixed the
> lpc32xx platform interrupt issue.
> 
> When switching to the new lpc32xx irqchip driver, a warning appear
> in the lpc32xx gpio driver: warning: "NR_IRQS" redefined.
> 
> To remove this warning (temporary solution), this patch
> disables the broken "to_irq" mapping functionality support.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Note:
> * For details on the lpc32xx irqchip patch, refer to:
>   http://thread.gmane.org/gmane.linux.drivers.devicetree/165620
> 
> * The final solution is to replace the existing lpc32xx gpio driver.
>   This work is currently in progress; refer to the following URL:
>   http://thread.gmane.org/gmane.linux.drivers.devicetree/144696
> 
>  drivers/gpio/gpio-lpc32xx.c | 48 +--------------------------------------------
>  1 file changed, 1 insertion(+), 47 deletions(-)
> 

the change looks good to me.

Probably all lpc32xx_gpio_to_irq* functions can be removed along with .to_irq
callback assignments, but it is up to you.


Acked-by: Vladimir Zapolskiy <vz@mleia.com>


--
With best wishes,
Vladimir
