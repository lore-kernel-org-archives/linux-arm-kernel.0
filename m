From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 9 Mar 2018 15:48:46 +0530
Subject: [PATCH v2] ARM: davinci: fix the GPIO lookup for omapl138-hawk
In-Reply-To: <20180301103448.27233-1-brgl@bgdev.pl>
References: <20180301103448.27233-1-brgl@bgdev.pl>
Message-ID: <49351196-c0a6-8b4e-ccc9-68e81f652ca3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2018 04:04 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
> mmc can correctly lookup the wp and cp gpios.
> 
> Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied for v4.16 with a note on the fact that the gpio-davinci
driver sets the chip label to davinci_gpio.0.

Thanks,
Sekhar

---8<---
ARM: davinci: fix the GPIO lookup for omapl138-hawk

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
mmc can correctly lookup the wp and cp gpios.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
[nsekhar at ti.com: add a note on where the chip label is set]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
