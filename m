From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 5 Sep 2014 16:23:30 +0200
Subject: [PATCH] pinctrl: single: fix freudian slip
In-Reply-To: <1409903739-25998-1-git-send-email-linus.walleij@linaro.org>
References: <1409903739-25998-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140905162330.75247029@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Linus Walleij wrote:
> commit 03e9f0cac5da6af85758276cb4624caf5911f2b9
> "pinctrl: clean up after enable refactoring"
> renamed the vtable callback .enable to .set_mux. The
> renaming was done manually, and one of the alterations
> contained a freudian slip. I confess, I am human.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-single.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 9032422ad18f..fb94b772ad62 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -519,7 +519,7 @@ static const struct pinmux_ops pcs_pinmux_ops = {
>  	.get_functions_count = pcs_get_functions_count,
>  	.get_function_name = pcs_get_function_name,
>  	.get_function_groups = pcs_get_function_groups,
> -	.set_mux = pcs_sex_mux,
> +	.set_mux = pcs_set_mux,
>  	.gpio_request_enable = pcs_request_gpio,
>  };
>  
Congrats, you passed the Turing test! ;)


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
