From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 3 Sep 2014 09:14:25 -0700
Subject: [PATCH] pinctrl: clean up after enable refactoring
In-Reply-To: <1409742329-17411-1-git-send-email-linus.walleij@linaro.org>
References: <1409742329-17411-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAJAp7OgyriJHCLmF4EkdqVV-9_-ve4wRb-jQER9y9-Q4nhd81A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 3, 2014 at 4:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
[..]
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 80a64cad907d..01eab47a746f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -134,9 +134,9 @@ static int msm_get_function_groups(struct pinctrl_dev *pctldev,
>         return 0;
>  }
>
> -static int msm_pinmux_enable(struct pinctrl_dev *pctldev,
> -                            unsigned function,
> -                            unsigned group)
> +static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
> +                             unsigned function,
> +                             unsigned group)
>  {
>         struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>         const struct msm_pingroup *g;
> @@ -170,7 +170,7 @@ static const struct pinmux_ops msm_pinmux_ops = {
>         .get_functions_count    = msm_get_functions_count,
>         .get_function_name      = msm_get_function_name,
>         .get_function_groups    = msm_get_function_groups,
> -       .enable                 = msm_pinmux_enable,
> +       .set_mux                = msm_pinmux_set_mux,
>  };
>
>  static int msm_config_reg(struct msm_pinctrl *pctrl,

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
