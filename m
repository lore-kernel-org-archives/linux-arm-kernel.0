From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 03 Mar 2014 15:22:43 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAyLzNdIHR0eS9zZXJpYWw6IGF0OTE6IHVzZSBtY3Ry?=
 =?UTF-8?B?bF9ncGlvIGhlbHBlcnM=?=
In-Reply-To: <1393845120-6340-3-git-send-email-richard.genoud@gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
 <1393845120-6340-3-git-send-email-richard.genoud@gmail.com>
Message-ID: <1393845763.742672413@f113.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????????,  3 ????? 2014, 12:11 +01:00 ?? Richard Genoud <noreply.rgenoud@gmail.com>:
> On sam9x5, dedicated CTS (and RTS) pins are unusable together with the
> LCDC, the EMAC, or the MMC because they share the same line.
> 
> Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
> so we have to control them via GPIO.
> 
> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
> signals.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

...
> +static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
> +{
> +	int err = 0;
> +
> +	p->gpios = mctrl_gpio_init(dev, 0);
> +	if (IS_ERR_OR_NULL(p->gpios))
> +		err = PTR_ERR(p->gpios);
> +
> +	return err;
> +}

So what happen if mctrl_gpio_init() returns NULL?
Your function return 0, ie not an error.
Just use IS_ERR() macro here.

Thanks.
---
