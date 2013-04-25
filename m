From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 25 Apr 2013 11:58:16 +0200
Subject: [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan
 controller
In-Reply-To: <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
Message-ID: <20130425095816.GC17771@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> new file mode 100644
> index 0000000..810b019
> --- /dev/null
> +++ b/drivers/hwmon/g762.c

Snip

> +
> +/*
> + * Configuration-related definitions
> + */
> +
> +struct g762_config {
> +	u32 fan_startv;
> +	u32 fan_gear_mode;
> +	u32 fan_div;
> +	u32 fan_pulses;
> +	u32 fan_target;
> +	u32 pwm_polarity;
> +	u32 pwm_enable;
> +	u32 pwm_freq;
> +	u32 pwm_mode;
> +};
> +
> +/*
> + * g762 default values: it is assumed that the fan is set for a 32KHz clock
> + * source, a fan clock divisor of 1 and two pulses per revolution. Default
> + * fan driving mode is linear mode (g762/g763 also support PWM mode). Note
> + * the specific init value for properties which may be left unmodified.
> + */
> +#define G762_DEFAULT_CLK            32768
> +#define G762_DEFAULT_FAN_DIV        1
> +#define G762_DEFAULT_FAN_PULSES     2
> +#define G762_DEFAULT_OUT_MODE       0
> +#define G762_DEFAULT_FAN_MODE       2

Maybe you could use here the same macros as the ones used in the
do_set_* functions:

#define G762_DEFAULT_OUT_MODE		OUT_MODE_DAC
#define G762_DEFAULT_FAN_MODE		FAN_MODE_CLOSED_LOOP

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130425/3ed71656/attachment.sig>
