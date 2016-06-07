From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Jun 2016 16:28:39 +0200
Subject: [PATCH] clocksource/drivers/armada-370-xp: make syscore_ops static
In-Reply-To: <1465309073-20584-1-git-send-email-ben.dooks@codethink.co.uk>
 (Ben Dooks's message of "Tue, 7 Jun 2016 15:17:53 +0100")
References: <1465309073-20584-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <87k2i1oyy0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,
 
 On mar., juin 07 2016, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The driver does not export armada_370_xp_timer_syscore_ops so
> make it static to fix the following warning:
>
> drivers/clocksource/time-armada-370-xp.c:249:20: warning: symbol 'armada_370_xp_timer_syscore_ops' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/clocksource/time-armada-370-xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index d93ec3c..601dbf74 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -246,7 +246,7 @@ static void armada_370_xp_timer_resume(void)
>  	writel(timer0_local_ctrl_reg, local_base + TIMER_CTRL_OFF);
>  }
>  
> -struct syscore_ops armada_370_xp_timer_syscore_ops = {
> +static struct syscore_ops armada_370_xp_timer_syscore_ops = {
>  	.suspend	= armada_370_xp_timer_suspend,
>  	.resume		= armada_370_xp_timer_resume,
>  };
> -- 
> 2.8.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
