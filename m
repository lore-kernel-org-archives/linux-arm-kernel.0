From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 7 Aug 2013 14:57:25 +0100
Subject: [PATCH] ARM: ux500: fix devicetree builds
In-Reply-To: <1375883212-3266-1-git-send-email-linus.walleij@linaro.org>
References: <1375883212-3266-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130807135725.GD18668@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Aug 2013, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@stericsson.com>
> 
> The patch set beginning with commit:
> "ARM: ux500: Apply a ste-* prefix onto snowball.dts"
> thru commit:
> "ARM: ux500: Remove u9540.dts as it's been replaced"
> altered the names of the ux500 device tree files but forgot
> to:
> 
> - Rename the ccu8540-pinctrl.dtsi file
> 
> - Update #include statements from files using these
>   files, so the build broke.
> 
> - Update the Makefile for the device trees so the build
>   broke.
> 
> Fix it up so we can build them all again.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/boot/dts/Makefile                 |  10 +-
>  arch/arm/boot/dts/ccu8540-pinctrl.dtsi     | 196 -----------------------------
>  arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi | 196 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ste-ccu8540.dts          |   4 +-
>  arch/arm/boot/dts/ste-ccu9540.dts          |   2 +-
>  arch/arm/boot/dts/ste-href.dtsi            |   2 +-
>  arch/arm/boot/dts/ste-hrefprev60.dts       |   6 +-
>  arch/arm/boot/dts/ste-hrefv60plus.dts      |   6 +-
>  arch/arm/boot/dts/ste-snowball.dts         |   2 +-
>  9 files changed, 212 insertions(+), 212 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/ccu8540-pinctrl.dtsi
>  create mode 100644 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi

I would have been (and still am) happy to fixup the original patches
if you think that is a better approach.

If you think this way is better, feel free to add my Acked-by to this
patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
