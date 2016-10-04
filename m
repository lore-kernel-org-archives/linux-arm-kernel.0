From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Oct 2016 09:57:07 +0800
Subject: [PATCH 2/9] pinctrl: sunxi: Add bindings define
In-Reply-To: <f56e271107221a2f41f256e2759a92cfe29624a8.1475489558.git-series.maxime.ripard@free-electrons.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <f56e271107221a2f41f256e2759a92cfe29624a8.1475489558.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65V2VjFujJBNRJoAvOKF5p1aE0vJOp-4NeBJHiMH8y80Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Since we have some bindings header for our hardcoded flags, let's use them
> when we can.

"Use macros from bindings header file for DT parsing"

would make the subject clearer.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 64f7f6dcc027..5be455d5e252 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -28,6 +28,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
>  #include "../core.h"
>  #include "../../gpio/gpiolib.h"
>  #include "pinctrl-sunxi.h"
> @@ -164,9 +166,9 @@ static int sunxi_pctrl_parse_bias_prop(struct device_node *node)
>                 return -EINVAL;
>
>         switch (val) {
> -       case 1:
> +       case SUN4I_PINCTRL_PULL_UP:
>                 return PIN_CONFIG_BIAS_PULL_UP;
> -       case 2:
> +       case SUN4I_PINCTRL_PULL_DOWN:
>                 return PIN_CONFIG_BIAS_PULL_DOWN;
>         }
>
> --
> git-series 0.8.10
