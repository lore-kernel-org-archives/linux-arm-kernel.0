From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 23 Jun 2013 11:59:19 +0200
Subject: [PATCH] clocksource: samsung_pwm: Correct definition of
 AUTORELOAD bit
In-Reply-To: <1371577267-2860-1-git-send-email-tomasz.figa@gmail.com>
References: <1371577267-2860-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <4314851.1Z5ihu2ZPz@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 of June 2013 19:41:07 Tomasz Figa wrote:
> PWM channel 4 (logically channel 5 in TCON register) has its autoreload
> bit located at different position. This patch fixes the driver to
> account for this.
> 
> This fixes a problem with clocksource hanging after it overflows because
> it is not reloaded any more.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/clocksource/samsung_pwm_timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/samsung_pwm_timer.c
> b/drivers/clocksource/samsung_pwm_timer.c index 2977043..6af178f 100644
> --- a/drivers/clocksource/samsung_pwm_timer.c
> +++ b/drivers/clocksource/samsung_pwm_timer.c
> @@ -47,7 +47,8 @@
>  #define TCON_START(chan)		(1 << (4 * (chan) + 0))
>  #define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
>  #define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
> -#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
> +#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) \
> +						+ (((chan) < 5) ? 3 : 2)))
> 
>  DEFINE_SPINLOCK(samsung_pwm_lock);
>  EXPORT_SYMBOL(samsung_pwm_lock);

Ping.

Best regards,
Tomasz
