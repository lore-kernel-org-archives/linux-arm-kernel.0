From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 17:51:35 -0700
Subject: [PATCH v3 2/9] gpio: Introduce gpio descriptor 'name'
In-Reply-To: <1439561466-14350-3-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-3-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdbkkUVmdbDWOPgm4yro28kb0_zkBcaMVGjCFk3Yr75MTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 7:10 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The latest gpio hogging mechanism assigns each gpio a 'line-name' in the
> devicetree. The 'name' field is different from the 'label' field.
> 'label' is only used for requested GPIOs to describe its current use by
> driver or userspace.
>
> The 'name' field describes the GPIO itself, not the use. This is most
> likely identical to the label in the schematic on the GPIO line and
> should help to find this particular GPIO.
>
> This is equivalent to the gpiochip->names array. However names should be
> stored in the GPIO descriptor. We will use gpiochip->names in the future
> only as initializer for the GPIO descriptors for drivers that assign
> GPIO names hardcoded. All other GPIO names will be parsed from DT and
> directly assigned to the GPIO descriptor.
>
> This patch adds a helper function to find gpio descriptors by name
> instead of gpio number.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
