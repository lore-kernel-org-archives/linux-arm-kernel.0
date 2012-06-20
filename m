From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Wed, 20 Jun 2012 09:14:00 +0530
Subject: [PATCH] pinctrl/coh901: use clk_prepare_enable()
In-Reply-To: <1340141912-13111-1-git-send-email-linus.walleij@stericsson.com>
References: <1340141912-13111-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CADTbHxrmDQZ8UpSVwDPXiD21SrqUmid-fQ_9+eVBVaAk08MaDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 3:08 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The COH901 GPIO driver did not prepare its clock, so let us
> fix it to do so.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?drivers/pinctrl/pinctrl-coh901.c | ? ?2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
> index 55697a5..1b5d232a 100644
> --- a/drivers/pinctrl/pinctrl-coh901.c
> +++ b/drivers/pinctrl/pinctrl-coh901.c
> @@ -770,7 +770,7 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?dev_err(gpio->dev, "could not get GPIO clock\n");
> ? ? ? ? ? ? ? ?goto err_no_clk;
> ? ? ? ?}
> - ? ? ? err = clk_enable(gpio->clk);
> + ? ? ? err = clk_prepare_enable(gpio->clk);
> ? ? ? ?if (err) {
> ? ? ? ? ? ? ? ?dev_err(gpio->dev, "could not enable GPIO clock\n");
> ? ? ? ? ? ? ? ?goto err_no_clk_enable;

What about clk_disable_unprepare() in error path?

Regards,
Pankaj Jangra
