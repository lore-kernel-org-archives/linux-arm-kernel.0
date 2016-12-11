From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 11 Dec 2016 22:50:28 +0100
Subject: [PATCH] pinctrl: meson: fix gpio request disabling other modes
In-Reply-To: <20161206140817.11708-1-narmstrong@baylibre.com>
References: <20161206140817.11708-1-narmstrong@baylibre.com>
Message-ID: <20161211215028.GA22499@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:08:16PM +0100, Neil Armstrong wrote:
> The pinctrl_gpio_request is called with the "full" gpio number, already
> containing the base, then meson_pmx_request_gpio is then called with the
> final pin number.
> Remove the base addition when calling meson_pmx_disable_other_groups.
> 
> Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
> CC: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Beniamino Galvani <b.galvani@gmail.com>
