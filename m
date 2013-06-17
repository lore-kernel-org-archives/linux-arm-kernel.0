From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 17 Jun 2013 07:57:31 +0200
Subject: [PATCH] pinctrl: establish pull-up/pull-down terminology
In-Reply-To: <1371379548-6482-1-git-send-email-linus.walleij@stericsson.com>
References: <1371379548-6482-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20926.42315.907448.451620@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij writes:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> It is counter-intuitive to have "0" mean disable in a boolean
> manner for electronic properties of pins such as pull-up and
> pull-down. Therefore, define that a pull-up/pull-down argument
> of 0 to such a generic option means that the pin is
> short-circuited to VDD or GROUND. Pull disablement shall be
> done using PIN_CONFIG_BIAS_DISABLE.
> 
> Cc: Heiko St?bner <heiko@sntech.de>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/pinctrl/pinconf-generic.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
> index d414a77..67780f5 100644
> --- a/include/linux/pinctrl/pinconf-generic.h
> +++ b/include/linux/pinctrl/pinconf-generic.h
> @@ -36,14 +36,15 @@
>   *	tristate. The argument is ignored.
>   * @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
>   *	impedance to VDD). If the argument is != 0 pull-up is enabled,
> - *	if it is 0, pull-up is disabled.
> + *	if it is 0, pull-up it total, i.e. the pin is connected to VDD.
                            ^^
'is'?



Lothar Wa??mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra??e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch??ftsf??hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
