From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 11:59:13 +0200
Subject: [PATCH] ARM: orion5x: make orion5x_legacy_handle_irq static
In-Reply-To: <1465466345-29560-1-git-send-email-ben.dooks@codethink.co.uk>
 (Ben Dooks's message of "Thu, 9 Jun 2016 10:59:05 +0100")
References: <1465466345-29560-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <874m8tbgjy.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,
 
 On jeu., juin 09 2016, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The orion5x_legacy_handle_irq() is not used or declared outside
> of irq.c so make it static to avoid the following warning:
>
> arch/arm/mach-orion5x/irq.c:30:23: warning: symbol 'orion5x_legacy_handle_irq' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied on mvebu/cleanup

Thanks,

Gregory

> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-orion5x/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
> index de980ef..ac4af22 100644
> --- a/arch/arm/mach-orion5x/irq.c
> +++ b/arch/arm/mach-orion5x/irq.c
> @@ -26,7 +26,7 @@ static int __initdata gpio0_irqs[4] = {
>  	IRQ_ORION5X_GPIO_24_31,
>  };
>  
> -asmlinkage void
> +static asmlinkage void
>  __exception_irq_entry orion5x_legacy_handle_irq(struct pt_regs *regs)
>  {
>  	u32 stat;
> -- 
> 2.8.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
