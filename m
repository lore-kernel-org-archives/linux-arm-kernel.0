From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 28 Jan 2018 15:23:10 -0800
Subject: [PATCH] pinctrl: msm: allow the gpio base to be configurable
In-Reply-To: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
References: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
Message-ID: <20180128232310.GA12728@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 25 Jan 13:20 PST 2018, Timur Tabi wrote:

> Add an integer to the msm_pinctrl_soc_data struct that pinctrl-msm
> client drivers can use to specify the gpio base.  This is useful
> if the client driver wants to register multiple TLMM devices, because
> each one needs a distinct base.
> 
> pinctrl-msm currently sets the base to 0, which ensures that GPIOs
> of the first TLMM are numbered 0..n-1.  It could specify -1 as the
> base, which would tell gpiolib to choose a unique base, but this
> has the side-effect of choosing a non-zero base for all TLMMs:

What platform has multiple TLMMs?

[..]

> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index b7b6849625ec..4dc76e15bd14 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -901,7 +901,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  		return -EINVAL;
>  
>  	chip = &pctrl->chip;
> -	chip->base = 0;

My bad, this should have been -1.

Regards,
Bjorn
