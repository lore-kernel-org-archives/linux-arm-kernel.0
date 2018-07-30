From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Mon, 30 Jul 2018 13:09:14 +0900
Subject: [PATCH] pinctrl: uniphier: add spi pin-mux settings
In-Reply-To: <CACRpkdYD6FT9k50kc4kSx_nzv91wTeBYgJ1jHVrbFDY-XMaB9w@mail.gmail.com>
References: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com>
 <CACRpkdYD6FT9k50kc4kSx_nzv91wTeBYgJ1jHVrbFDY-XMaB9w@mail.gmail.com>
Message-ID: <002801d427bb$13b8e900$3b2abb00$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

I have sent modified patch for this bag as v2.
Please refer to the following.

[PATCH v2]
https://patchwork.kernel.org/patch/10533929/

[Changes since v1]
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
-index 0f921a6..f912999 100644
+index 0f921a6..f086083 100644
 --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
 +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
 @@ -504,6 +504,8 @@ static const unsigned nand_cs1_pins[] = {22, 23};
@@ -390,7 +393,7 @@
  static const char * const i2c3_groups[] = {"i2c3"};
  static const char * const nand_groups[] = {"nand", "nand_cs1"};
  static const char * const sd_groups[] = {"sd"};
-+static const char * const spi_groups[] = {"spi0"};
++static const char * const spi0_groups[] = {"spi0"};
  static const char * const system_bus_groups[] = {"system_bus",
                                                 "system_bus_cs1",
                                                 "system_bus_cs2",


I mistook "spi0_groups" with " spi_groups",
so there was an undeclared error.

-----------------
Best Regards,
Keiji Hayashibara


> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Monday, July 30, 2018 5:47 AM
> To: Hayashibara, Keiji/?? ?? <hayashibara.keiji@socionext.com>
> Cc: Yamada, Masahiro/?? ?? <yamada.masahiro@socionext.com>; open list:GPIO SUBSYSTEM
> <linux-gpio@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-kernel at vger.kernel.org; Hayashi,
> Kunihiko/? ?? <hayashi.kunihiko@socionext.com>
> Subject: Re: [PATCH] pinctrl: uniphier: add spi pin-mux settings
> 
> On Thu, Jul 19, 2018 at 8:21 AM Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
> 
> > From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >
> > Add pin-mux settings for spi controller.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> 
> There is some problem with the test robot, can you comment/followup?
> 
> Yours,
> Linus Walleij
