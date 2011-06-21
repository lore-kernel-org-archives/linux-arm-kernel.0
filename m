From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Jun 2011 09:59:30 -0300
Subject: [PATCH 3/6] ARM: mach-imx/mx27_3ds: Add LCD support
In-Reply-To: <20110621121105.GZ23771@pengutronix.de>
References: <1308588522-16586-1-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-2-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-3-git-send-email-fabio.estevam@freescale.com>
	<20110621121105.GZ23771@pengutronix.de>
Message-ID: <BANLkTimWSxWcpO=z69eqruyZkt7CMo9x2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jun 21, 2011 at 9:11 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
>> ? ? ? mxc_gpio_mode(SPI2_SS0 | GPIO_GPIO | GPIO_OUT);
>> ? ? ? mxc_gpio_mode(PMIC_INT | GPIO_GPIO | GPIO_IN);
>> + ? ? mxc_gpio_mode(SPI1_SS0 | GPIO_GPIO | GPIO_OUT);
>> + ? ? mxc_gpio_mode(LCD_ENABLE | GPIO_GPIO | GPIO_OUT);
>> + ? ? mxc_gpio_mode(LCD_RESET | GPIO_GPIO | GPIO_OUT);
>
> You can add these to the static pin array instead.

I tried that initially and it caused all the gpio_request calls to fail.

The only way I could make gpio_request to work is when I define the
pin as gpio mode via mxc_gpio_mode.

Regards,

Fabio Estevam
