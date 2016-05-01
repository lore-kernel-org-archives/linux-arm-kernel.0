From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 May 2016 11:03:55 +0200
Subject: [PATCH 1/2] pinctrl: amlogic: Add support for Amlogic Meson GXBB
 SoC
In-Reply-To: <1462036875-22625-2-git-send-email-carlo@caione.org>
References: <1462036875-22625-1-git-send-email-carlo@caione.org>
 <1462036875-22625-2-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdbfSgVH_zGMdgyfvBbnpiTkd7dzugza4_w0_7MLMVNzyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2016 at 7:21 PM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> This patch adds the basic platform file to support the pin controller
> found on the Amlogic Meson GXBB SoCs.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

>  .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +

This thing conflicts with upstream. Make a separate patch for
updating the bindings I think.

>  arch/arm64/Kconfig.platforms                       |   2 +

This needs to be split off and sent separatelt to the ARM64
maintainers. Since it's just a symbol dependency (I think?) it
can be merged orthogonally.

>  drivers/pinctrl/meson/Makefile                     |   2 +-
>  drivers/pinctrl/meson/pinctrl-meson-gxbb.c         | 432 +++++++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson.c              |   8 +
>  drivers/pinctrl/meson/pinctrl-meson.h              |   2 +
>  include/dt-bindings/gpio/meson-gxbb-gpio.h         | 154 ++++++++
>  7 files changed, 601 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-gxbb.c
>  create mode 100644 include/dt-bindings/gpio/meson-gxbb-gpio.h

This stuff I can merge, if I get it in a separate patch.

> diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> index 32f4a2d..fe7fe0b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> @@ -5,6 +5,8 @@ Required properties for the root node:
>                       "amlogic,meson8b-cbus-pinctrl"
>                       "amlogic,meson8-aobus-pinctrl"
>                       "amlogic,meson8b-aobus-pinctrl"
> +                     "amlogic,meson-gxbb-periphs-pinctrl"
> +                     "amlogic,meson-gxbb-aobus-pinctrl"

This is not how upstream looks...

Yours,
Linus Walleij
