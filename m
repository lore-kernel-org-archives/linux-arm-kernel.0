From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 1 Aug 2018 22:23:00 +0200
Subject: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
In-Reply-To: <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
 <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> set the TEST_N pin direction.
> This patch adds a "smc" boolean to the bank structure to differentiate
> the TEST_N bank and call the Secure Monitor in the _input/_output functions.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pinctrl/meson/Kconfig         |  1 +
>  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
>  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
>  3 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
> index c80951d..1b90470 100644
> --- a/drivers/pinctrl/meson/Kconfig
> +++ b/drivers/pinctrl/meson/Kconfig
> @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
>         select GPIOLIB
>         select OF_GPIO
>         select REGMAP_MMIO
> +       select MESON_SM
I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
instead?
selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
don't have the GX secure monitor), but I haven't tested it yet


Regards
Martin
