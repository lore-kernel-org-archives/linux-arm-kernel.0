From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 10:30:50 +0000
Subject: [PATCH 11/12] ARM: ux500: Use the GPIO regulator framework for
 SDI0's 'en' and 'vsel'
In-Reply-To: <CAPDyKFo8NjiYdcyx3pk8byc1N2f7r+erQj74A1zhOaNK_WbkZA@mail.gmail.com>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-12-git-send-email-lee.jones@linaro.org>
 <CAPDyKFo8NjiYdcyx3pk8byc1N2f7r+erQj74A1zhOaNK_WbkZA@mail.gmail.com>
Message-ID: <20121210103050.GE9362@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +        .constraints = {
> > +                .min_uV         = 1800000,
> 
> 2.9V, not 3.3V

> > +static struct gpio_regulator_state sdi0_reg_states[] = {
> > +        { .value = 3300000, .gpios = (0 << 0) },
> 
> 2.9V, not 3.3V

I'm still a little unsure about this. I know the actual
voltage is v2.9, but the supported/requested MMC voltage
from the driver is v3.3.

Will it still work if I set it all up as v2.9?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
