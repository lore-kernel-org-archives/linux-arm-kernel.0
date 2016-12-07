From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 06 Dec 2016 16:47:41 -0800
Subject: [PATCH] pinctrl: meson: fix gpio request disabling other modes
In-Reply-To: <20161206140817.11708-1-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 6 Dec 2016 15:08:16 +0100")
References: <20161206140817.11708-1-narmstrong@baylibre.com>
Message-ID: <m2bmwoftua.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The pinctrl_gpio_request is called with the "full" gpio number, already
> containing the base, then meson_pmx_request_gpio is then called with the
> final pin number.
> Remove the base addition when calling meson_pmx_disable_other_groups.
>
> Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
> CC: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
