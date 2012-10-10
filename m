From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:37:42 +0200
Subject: [PATCH 03/16] pinctrl: samsung: Detect and handle unsupported
 configuration types
In-Reply-To: <1349685556-23718-4-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-4-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkda8mBsetmkWSfed0VpGA_Aw4vNUSGZcTx=bY8LDRzxFdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch modifies the pinctrl-samsung driver to detect when width of a
> bit field is set to zero (which means that such configuraton type is not
> supported) and return an error instead of trying to modify an inexistent
> register.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  drivers/pinctrl/pinctrl-samsung.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
> index dd108a9..c660fa5 100644
> --- a/drivers/pinctrl/pinctrl-samsung.c
> +++ b/drivers/pinctrl/pinctrl-samsung.c
> @@ -391,6 +391,9 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
>                 return -EINVAL;
>         }
>
> +       if (!width)
> +               return -EINVAL;
> +

Can this patch be applied in isolation from the others?
Thomas A: can you ACK this so I can apply it in that case?

Yours,
Linus Walleij
