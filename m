From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 17:17:08 -0700
Subject: [PATCH 13/14] ARM: ux500: enable AB8500 GPIO for HREF
In-Reply-To: <1360093715-6348-14-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-14-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5112F284.3040002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 12:48 PM, Linus Walleij wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> The AB8500 GPIO driver has been un-BROKEN and rewritten as a pinctrl
> driver. Now that it's back in use, let's ensure that it's available
> when booting HREF with Device Tree enabled.

> diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts

>  	soc-u9500 {
> +		prcmu at 80157000 {
> +			ab8500 at 5 {
> +				ab8500-gpio {
> +					compatible = "stericsson,ab8500-gpio";

The MFDs I've looked at (which admittedly might not be that many) all
have the top-level chip described in device tree, but not all the
component sub-devices, since they're all a static part of the top-level
chip. Instead, the top-level MFD instantiates all the sub-devices
itself. I'm curious why this MFD device works differently - do many work
like this?
