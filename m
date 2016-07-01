From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 1 Jul 2016 10:35:37 -0700
Subject: [PATCH] pinctrl: qcom: add support for EBI2
In-Reply-To: <1467388364-22223-1-git-send-email-linus.walleij@linaro.org>
References: <1467388364-22223-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160701173537.GL1190@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 01 Jul 08:52 PDT 2016, Linus Walleij wrote:

> Add support to mux in the second external bus interface as
> function 1 on pins 123 thru 158. This external bus is used on
> the APQ8060 Dragonboard to connect an external SMSC9211 ethernet
> adapter.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm8660.c | 82 +++++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8660.c b/drivers/pinctrl/qcom/pinctrl-msm8660.c
[..]
> @@ -875,42 +885,42 @@ static const struct msm_pingroup msm8660_groups[] = {
[..]
> +	PINGROUP(158, ebi2, _, _, _, _, _, _),

Looking at the default gpiomux-8x60.c in an old tree (the only one I've
found that defines ebi2) here seems to indicate that pin 158 is not part
of ebi2.

It also denotes pin 40 as "cs2" and skips 131 for some reason.


So I suggest dropping 158 and you have my
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
