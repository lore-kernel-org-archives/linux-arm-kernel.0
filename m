From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Nov 2018 14:19:25 +0100
Subject: [PATCH 2/3] gpio: davinci: restore a way to manually specify the
 GPIO base
In-Reply-To: <20181113135051.15308-3-brgl@bgdev.pl>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-3-brgl@bgdev.pl>
Message-ID: <CACRpkdZkZeVSi3O1AR-uZFcBEwp6BN95UxkgKHZz3FJbOHS3mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 2:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
> automatic base selection") broke the network support in legacy boot
> mode for da850-evm since we can no longer request the MDIO clock GPIO.
>
> Other boards may be broken too, which I haven't tested.
>
> The problem is in the fact that most board files still use the legacy
> GPIO API where lines are requested by numbers rather than descriptors.
>
> While this should be fixed eventually, in order to unbreak the board
> for now - provide a way to manually specify the GPIO base in platform
> data.
>
> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
> Cc: stable at vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this will be merged throug ARM SoC?

Yours,
Linus Walleij
