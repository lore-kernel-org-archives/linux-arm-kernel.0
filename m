From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Apr 2015 15:05:14 +0200
Subject: [PATCH] RFC: let gpiod_get_optional et all return NULL when
 GPIOLIB is not enabled
In-Reply-To: <CAAVeFu+0bWSAUSaDGTUmPyj9JxEJn4yxF_hzab4CHp8YV1MuoA@mail.gmail.com>
References: <1423731809-4800-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdb6KcZx3WfTqUKemhQ0_OsqxBGQb_P5cXXZvgc3riakdA@mail.gmail.com>
 <20150306085957.GC10717@pengutronix.de>
 <CACRpkdYq70V8SG4XOPBCGWs__J4ehknZSucpO5OdXpMDj8GPKA@mail.gmail.com>
 <CAAVeFu+0bWSAUSaDGTUmPyj9JxEJn4yxF_hzab4CHp8YV1MuoA@mail.gmail.com>
Message-ID: <CACRpkdbLRaEshEw-zCr49VUxULQ-gfT5LnHEL7Gz7jWr7NGOfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 9, 2015 at 4:20 AM, Alexandre Courbot <gnurou@gmail.com> wrote:

> Having GPIO disabled means there is no GPIO support, including the
> ability to look for GPIOs. -ENOSYS is a well-documented error-code
> which meaning also applies to the gpio_*_optional functions (we don't
> have support for the operation you requested). If a driver or
> architecture really, really needs GPIO support they can require or
> depend on CONFIG_GPIOLIB, and the problem goes away. If they can work
> with and without gpiolib, then they should check for -ENOSYS when they
> request GPIOs and behave accordingly.

Makes sense. We have ARCH_WANT_OPTIONAL_GPIOLIB and
ARCH_REQUIRE_GPIOLIB for this reason.

Yours,
Linus Walleij
