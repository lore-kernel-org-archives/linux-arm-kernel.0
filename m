From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Dec 2016 13:41:12 +0100
Subject: [PATCH] pinctrl: meson: fix gpio request disabling other modes
In-Reply-To: <20161206140817.11708-1-narmstrong@baylibre.com>
References: <20161206140817.11708-1-narmstrong@baylibre.com>
Message-ID: <CACRpkda=LtBe_Msmy4V5dBSkQ698A2DyaDmPqHGnEMdGHvXXEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 6, 2016 at 3:08 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> The pinctrl_gpio_request is called with the "full" gpio number, already
> containing the base, then meson_pmx_request_gpio is then called with the
> final pin number.
> Remove the base addition when calling meson_pmx_disable_other_groups.
>
> Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
> CC: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied for fixes. Sorry for the delay, merge window appeared inbetween.

Yours,
Linus Walleij
