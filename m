From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 16:34:52 -0600
Subject: [PATCH v2 10/16] pwm: Add PWM modes
In-Reply-To: <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 04:22:57PM +0200, Claudiu Beznea wrote:
> Define a macros for PWM modes to be used by device tree sources.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  include/dt-bindings/pwm/pwm.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> index ab9a077e3c7d..b8617431f8ec 100644
> --- a/include/dt-bindings/pwm/pwm.h
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -12,4 +12,7 @@
>  
>  #define PWM_POLARITY_INVERTED			(1 << 0)
>  
> +#define PWM_DTMODE_NORMAL			(1 << 0)

Bit 0 is already taken. I think you mean (0 << 1)?

Personally, I'd just drop this define. A define for a 0 value makes more 
sense when each state is equally used (like active high or low), but if 
0 is the more common case, then I don't the need for a define.

> +#define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
> +
>  #endif
> -- 
> 2.7.4
> 
