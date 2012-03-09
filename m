From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Mar 2012 18:00:46 -0300
Subject: [PATCH v2] ARM : mx35: 3ds-board: add framebuffer device
In-Reply-To: <1320381217-28711-1-git-send-email-b39297@freescale.com>
References: <1320381217-28711-1-git-send-email-b39297@freescale.com>
Message-ID: <CAOMZO5AvJ1SxOBkHom97MeNOktodj=si3moq+VJB_FaHXwpHOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 2:33 AM, wu guoxing <b39297@freescale.com> wrote:

> +static int mc9s08dz60_lcd_gpio_get(void)
> +{
> + ? ? ? int ret;
> + ? ? ? struct gpio_chip *chip;
> + ? ? ? chip = gpiochip_find(
> + ? ? ? ? ? ? ? ? ? ? ? "mc9s08dz60", mc9s08dz60_gpiochip_match);
> + ? ? ? if (chip)
> + ? ? ? ? ? ? ? ret = chip->base + 6;

Please add a define to replace this magic "6".

The extra defines would be also useful for people that want to access
the other GPIOs from mc9s08dz60.

Regards,

Fabio Estevam
