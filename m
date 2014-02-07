From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 07 Feb 2014 19:21:34 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA1LzhdIHR0eS9zZXJpYWw6IGF0OTE6IGFkZCBkdHIgY29u?=
 =?UTF-8?B?dHJvbCB2aWEgZ3Bpbw==?=
In-Reply-To: <1391785155-18525-6-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
 <1391785155-18525-6-git-send-email-richard.genoud@gmail.com>
Message-ID: <1391786494.259974704@f81.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????,  7 ??????? 2014, 15:59 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> On sam9x5, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
> so we have to control them via GPIO.
> 
> This patch permits to use a GPIO to control the DTR signal.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
...
> +	if (gpio_is_valid(atmel_port->gpio.dtr)) {
> +		if (mctrl & TIOCM_DTR)
> +			gpio_set_value(atmel_port->gpio.dtr, 0);
> +		else
> +			gpio_set_value(atmel_port->gpio.dtr, 1);
> +	}

So, if you use GPIO for such purpose (here and in the other patches),
you should take and use GPIO active level from bindings.
It will make use of GPIO more flexible and deliver us from further special
possible bindings to declare the active level.
Actually, it would be good to have a separate unit for mctrl GPIOs,
which could be used for other drivers.

---
