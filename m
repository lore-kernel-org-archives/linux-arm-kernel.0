From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Thu, 2 Sep 2010 16:55:27 +0200
Subject: [PATCH] ARM: nomadik: move nmk_gpio_probe to .devinit.text
In-Reply-To: <1283435427-14115-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100809065933.GA900@bnru01.bnr.st.com>
	<1283435427-14115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTinU=E0aek4CA73wLTfb1yArpE4u=YpHQTpvS+rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/9/2 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This fixes a section mismatch reported by modpost:
>
> ? ? ? ?WARNING: arch/arm/plat-nomadik/built-in.o(.data+0x100): Section mismatch in reference from the variable nmk_gpio_driver to the function .init.text:nmk_gpio_probe()
> ? ? ? ?The variable nmk_gpio_driver references
> ? ? ? ?the function __init nmk_gpio_probe()
> ? ? ? ?If the reference is valid then annotate the
> ? ? ? ?variable with __init* or __refdata (see linux/init.h) or name the variable:
> ? ? ? ?*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> According to Rabin VINCENT the alternative to use platform_driver_probe
> won't work because the "platform devices are not yet registered when
> nmk_gpio_init() is called."
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Rabin Vincent <rabin.vincent@stericsson.com>

Thanks,
Rabin
