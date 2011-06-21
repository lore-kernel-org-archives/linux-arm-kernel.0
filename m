From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Jun 2011 10:57:14 -0300
Subject: [PATCH 3/6] ARM: mach-imx/mx27_3ds: Add LCD support
In-Reply-To: <BANLkTimWSxWcpO=z69eqruyZkt7CMo9x2Q@mail.gmail.com>
References: <1308588522-16586-1-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-2-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-3-git-send-email-fabio.estevam@freescale.com>
	<20110621121105.GZ23771@pengutronix.de>
	<BANLkTimWSxWcpO=z69eqruyZkt7CMo9x2Q@mail.gmail.com>
Message-ID: <BANLkTinmCVrMLEfPR5BwAOStHbR2faO=Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jun 21, 2011 at 9:59 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Sascha,
>
> On Tue, Jun 21, 2011 at 9:11 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> ...
>>> ? ? ? mxc_gpio_mode(SPI2_SS0 | GPIO_GPIO | GPIO_OUT);
>>> ? ? ? mxc_gpio_mode(PMIC_INT | GPIO_GPIO | GPIO_IN);
>>> + ? ? mxc_gpio_mode(SPI1_SS0 | GPIO_GPIO | GPIO_OUT);
>>> + ? ? mxc_gpio_mode(LCD_ENABLE | GPIO_GPIO | GPIO_OUT);
>>> + ? ? mxc_gpio_mode(LCD_RESET | GPIO_GPIO | GPIO_OUT);
>>
>> You can add these to the static pin array instead.
>
> I tried that initially and it caused all the gpio_request calls to fail.
>
> The only way I could make gpio_request to work is when I define the
> pin as gpio mode via mxc_gpio_mode.


I managed to put these definitions in the static pin array as you suggested.

In order to do so, I had to fix iomux-v1.c. I will send a v2 version
including the iomux-v1 fix.

Please let me know if you have any other comments in the other patches
so that I can consider them for v2.

Thanks,

Fabio Estevam
