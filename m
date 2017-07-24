From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 24 Jul 2017 10:34:48 +0200
Subject: [PATCH] pwm: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-45-robh@kernel.org>
References: <20170718214339.7774-45-robh@kernel.org>
Message-ID: <5e9dfdc9-4c98-8e4a-f95d-7632bad21d2f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2017 11:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-pwm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-amlogic at lists.infradead.org
> ---
>  drivers/pwm/pwm-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index cb845edfe2b4..d589331d1884 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -441,7 +441,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	for (i = 0; i < meson->chip.npwm; i++) {
>  		struct meson_pwm_channel *channel = &channels[i];
> 
> -		snprintf(name, sizeof(name), "%s#mux%u", np->full_name, i);
> +		snprintf(name, sizeof(name), "%pOF#mux%u", np, i);
> 
>  		init.name = name;
>  		init.ops = &clk_mux_ops;
> --
> 2.11.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
