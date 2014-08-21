From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 21 Aug 2014 09:59:47 +0530
Subject: [PATCH] pinctrl: spear: Make of_device_id array const
In-Reply-To: <1408544800-24628-1-git-send-email-kiran.padwal@smartplayin.com>
References: <1408544800-24628-1-git-send-email-kiran.padwal@smartplayin.com>
Message-ID: <CAOh2x=nf+s3WKrWatmmvp4Nn+=gZgSsAFscXSmwchT7c63YKHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 7:56 PM, Kiran Padwal
<kiran.padwal@smartplayin.com> wrote:
> Make of_device_id array const, because all OF functions handle it as const.
>
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/pinctrl/spear/pinctrl-spear1310.c |    2 +-
>  drivers/pinctrl/spear/pinctrl-spear1340.c |    2 +-
>  drivers/pinctrl/spear/pinctrl-spear300.c  |    2 +-
>  drivers/pinctrl/spear/pinctrl-spear310.c  |    2 +-
>  drivers/pinctrl/spear/pinctrl-spear320.c  |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
> index 1a8bbfe..6d57d43 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear1310.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
> @@ -2692,7 +2692,7 @@ static struct spear_pinctrl_machdata spear1310_machdata = {
>         .modes_supported = false,
>  };
>
> -static struct of_device_id spear1310_pinctrl_of_match[] = {
> +static const struct of_device_id spear1310_pinctrl_of_match[] = {
>         {
>                 .compatible = "st,spear1310-pinmux",
>         },
> diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
> index 873966e..d243e43 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear1340.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
> @@ -2008,7 +2008,7 @@ static struct spear_pinctrl_machdata spear1340_machdata = {
>         .modes_supported = false,
>  };
>
> -static struct of_device_id spear1340_pinctrl_of_match[] = {
> +static const struct of_device_id spear1340_pinctrl_of_match[] = {
>         {
>                 .compatible = "st,spear1340-pinmux",
>         },
> diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
> index 4777c0d..9db83e9 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear300.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear300.c
> @@ -646,7 +646,7 @@ static struct spear_function *spear300_functions[] = {
>         &gpio1_function,
>  };
>
> -static struct of_device_id spear300_pinctrl_of_match[] = {
> +static const struct of_device_id spear300_pinctrl_of_match[] = {
>         {
>                 .compatible = "st,spear300-pinmux",
>         },
> diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
> index ed1d360..db775a4 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear310.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear310.c
> @@ -371,7 +371,7 @@ static struct spear_function *spear310_functions[] = {
>         &tdm_function,
>  };
>
> -static struct of_device_id spear310_pinctrl_of_match[] = {
> +static const struct of_device_id spear310_pinctrl_of_match[] = {
>         {
>                 .compatible = "st,spear310-pinmux",
>         },
> diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
> index b8e290a..80fbd68 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear320.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear320.c
> @@ -3410,7 +3410,7 @@ static struct spear_function *spear320_functions[] = {
>         &i2c2_function,
>  };
>
> -static struct of_device_id spear320_pinctrl_of_match[] = {
> +static const struct of_device_id spear320_pinctrl_of_match[] = {
>         {
>                 .compatible = "st,spear320-pinmux",
>         },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
