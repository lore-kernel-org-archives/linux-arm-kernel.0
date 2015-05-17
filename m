From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 May 2015 16:30:14 +0200
Subject: [PATCH v2 07/10] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <1431707940-19372-8-git-send-email-jenskuske@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-8-git-send-email-jenskuske@gmail.com>
Message-ID: <20150517143014.GH4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 06:38:57PM +0200, Jens Kuske wrote:
> The H3 uses the same pin controller as previous SoC's from Allwinner.
> Add support for the pins controlled by the main PIO controller.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>  drivers/pinctrl/sunxi/Kconfig                      |   8 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c           | 522 +++++++++++++++++++++
>  4 files changed, 532 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index fdd8046..c46af8e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -16,6 +16,7 @@ Required properties:
>    "allwinner,sun7i-a20-pinctrl"
>    "allwinner,sun8i-a23-pinctrl"
>    "allwinner,sun8i-a23-r-pinctrl"
> +  "allwinner,sun8i-h3-pinctrl"
>  - reg: Should contain the register physical address and length for the
>    pin controller.
>  
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 2eb893e..6c1cec5 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -43,6 +43,14 @@ config PINCTRL_SUN8I_A23_R
>  	depends on RESET_CONTROLLER
>  	select PINCTRL_SUNXI_COMMON
>  
> +config PINCTRL_SUN8I_H3
> +	tristate "Allwinner H3 pinctrl driver"
> +	default MACH_SUN8I
> +	select PINCTRL_SUNXI_COMMON

PINCTRL_SUNXI_COMMON should probably be turned into a tristate as well

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150517/5e215f8c/attachment-0001.sig>
