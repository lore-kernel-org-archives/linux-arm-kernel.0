From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Nov 2018 13:18:23 +0100
Subject: [PATCH 1/2] pinctrl: rockchip: allow specifying the regmap
 location for pin-routes
In-Reply-To: <20181111210047.30375-1-heiko@sntech.de>
References: <20181111210047.30375-1-heiko@sntech.de>
Message-ID: <CACRpkdbakPGfHap+WcuJ_TVn861zqQDxW-on4q9Wx+-QQb0ESw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2018 at 10:01 PM Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@bq.com>
>
> Right now we expect the pin-rounting settings to be in the same area
> as the iomux setting itself. And while that seems to be true for all
> newer Rockchip socs, back in the wild west days of old this wasn't true.
>
> Nowadays pin settings in the GRF normally stay in the GRF and the same
> is true for pins configured from PMU registers. But old socs like the
> rk3188 really sprinkle pin settings somewhat randomly through both
> for its bank0.
>
> Therefore add the option to specify a location for the route setting,
> so that we can map older socs correctly. We'll keep "same" as the
> default, so that we only need to specify a location in the corner-cases
> described above.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Patch applied with David's review tag.

Yours,
Linus Walleij
