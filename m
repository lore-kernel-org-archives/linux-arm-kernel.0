From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 7 Aug 2013 15:01:57 +0100
Subject: [PATCH] ARM: ux500: fix devicetree builds
In-Reply-To: <1375883212-3266-1-git-send-email-linus.walleij@linaro.org>
References: <1375883212-3266-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130807140157.GF18668@lee--X1>
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

... also, I think you wanted to use `git format-patch -M` here.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
