From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 27 Oct 2009 21:43:26 +0200
Subject: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
In-Reply-To: <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	<20090930155557.7dae503b@hskinnemoen-d830>
	<a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
Message-ID: <cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Nicolas,

> + ? ? ? if (data->slot[0].wp_pin)
> + ? ? ? ? ? ? ? at91_set_gpio_input(data->slot[0].wp_pin, 1);

> +static struct mci_platform_data __initdata mci0_data = {
> + ? ? ? .slot[0] = {
> + ? ? ? ? ? ? ? .bus_width ? ? ?= 4,
> + ? ? ? ? ? ? ? .detect_pin ? ? = AT91_PIN_PD10,
> + ? ? ? ? ? ? ? .wp_pin ? ? ? ? = -1,
> + ? ? ? },

Causes at91_set_gpio_input() to be called for pin -1.  Which shouldn't be valid.
AT91 platforms use 0 to indicate an un-connected GPIO pin, so the
assignment of "wp_pin" should probably just be removed.


Regards,
  Andrew Victor
