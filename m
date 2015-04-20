From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 20 Apr 2015 15:32:51 +0300
Subject: [PATCH] pinctrl: mediatek: mtk-common: initialize unmask
In-Reply-To: <1429528516-9245-1-git-send-email-colin.king@canonical.com>
References: <1429528516-9245-1-git-send-email-colin.king@canonical.com>
Message-ID: <5534F1F3.9060802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/20/2015 02:15 PM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>

> cppcheck detected an unitialized variable:

    Uninitialized.

> [drivers/pinctrl/mediatek/pinctrl-mtk-common.c:897]:
>    (error) Uninitialized variable: unmask

> unmask should be initialized to zero to ensure unmasking
> only occurs if a previous mask occurred. The current situation
> is that the unmask variable could contain any random garbage
> causing random unexpected unmasking.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 493294c..3173125 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -881,7 +881,8 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
>   	if (!mtk_eint_get_mask(pctl, eint_num)) {
>   		mtk_eint_mask(d);
>   		unmask = 1;
> -	}
> +	} else
> +		unmask = 0;

    The CodingStyle dictates that there should be {} around *else* branch too.

[...]

WBR, Sergei
