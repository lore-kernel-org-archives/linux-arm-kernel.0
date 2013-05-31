From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 12:47:44 +0200
Subject: [PATCH 31/39] ARM: u300: add syscon node
In-Reply-To: <1369991954-17406-32-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-32-git-send-email-linus.walleij@stericsson.com>
Message-ID: <14733989.vf3LkZC316@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 11:19:06 Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds a device tree node for the U300 system controller
> and remaps this dynamically instead of using hard-coded
> virtual addresses. The board power set-up code is altered
> to fetch a reference to the syscon using ampersand <&syscon>
> notation. This way of passing a pointer to the syscon will
> also be used by the clocks.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/ste-u300.txt | 30 +++++++++++++++++++---
>  arch/arm/boot/dts/ste-u300.dts                     |  6 +++++
>  arch/arm/mach-u300/core.c                          | 22 +++++++++++++---
>  arch/arm/mach-u300/regulator.c                     | 21 ++++++++++++---
>  4 files changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ste-u300.txt b/Documentation/devicetree/bindings/arm/ste-u300.txt
> index cd9001a..69b5ab0 100644
> --- a/Documentation/devicetree/bindings/arm/ste-u300.txt
> +++ b/Documentation/devicetree/bindings/arm/ste-u300.txt
> @@ -8,15 +8,39 @@ Required root node property:
>  
>  compatible="stericsson,u300";
>  
> +Required node: syscon
> +This contains the system controller.
> +- compatible: must be "stericsson,u300-syscon".
> +- reg: the base address and size of the system controller.
> +

Any reason why you are not making it compatible with "syscon", to use
the drivers/mfd/syscon.c driver?

	Arnd 
