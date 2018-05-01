From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 May 2018 00:23:38 +0800
Subject: [PATCH 03/21] clk: sunxi-ng: Enable DE2_CCU for Allwinner 64-bit
 SoCs
In-Reply-To: <20180430114058.5061-4-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-4-jagan@amarulasolutions.com>
Message-ID: <CAGb2v66MKooAAroCzYdsXZDY0Oh66Dydpy59xj80QfiY+5mz_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 7:40 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Allwinner 64-bit SoC like H5/A64 has DE2 CCU so enable them
> as default.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 79dfd296c3d1..1fffd3bf6ff3 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -58,6 +58,8 @@ config SUN8I_V3S_CCU
>
>  config SUN8I_DE2_CCU
>         bool "Support for the Allwinner SoCs DE2 CCU"
> +       default ARM64 && ARCH_SUNXI
> +       depends on (DRM_SUN4I && (ARM64 && ARCH_SUNXI)) || COMPILE_TEST

There is no reason to depend on DRM_SUN4I. There is no compile dependency.

Also, this is needed on SUN8I as well, pretty much anything with DE 2.0.
So you shouldn't limit it to ARM64. That pretty much breaks things for
people with A83T's or H3's. In fact you should enable it by default for
these as well.

ChenYu

>
>  config SUN8I_R40_CCU
>         bool "Support for the Allwinner R40 CCU"
> --
> 2.14.3
>
