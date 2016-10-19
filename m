From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 19 Oct 2016 13:20:54 -0300
Subject: [PATCH v4] MMC: meson: initial support for GX platforms
In-Reply-To: <20161018195605.21145-1-khilman@baylibre.com>
References: <20161018195605.21145-1-khilman@baylibre.com>
Message-ID: <CABxcv=kQBAdXtks-tX1t-CkPnvFx0SWa3JzLRYK4KWk+EGZedw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Tue, Oct 18, 2016 at 4:56 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Initial support for the SD/eMMC controller in the Amlogic S905/GX*
> family of SoCs.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

[snip]

> +
> +MODULE_ALIAS("platform:" DRIVER_NAME);

Why is this module alias needed? I thought that the Amlogic was a
DT-only platform and so devices will always be registered from OF (and
the OF modalias used).

I've seen platform module aliases in other Meson drivers too (i.e:
meson-rng and meson-pwm), so the same question applies to those.

Best regards,
Javier
