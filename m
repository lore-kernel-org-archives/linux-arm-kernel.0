From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 28 Jan 2017 20:47:56 +0800
Subject: [linux-sunxi] [PATCH v2 7/9] dmaengine: sun6i: allow build on
 ARM64 platforms (sun50i)
In-Reply-To: <20170126154859.55855-8-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-8-icenowy@aosc.xyz>
Message-ID: <CAGb2v65TmeehtPJ=ewyCMfE42xJgzr7Ak9qxOaqeD7UXoLFpvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> As 64-bot Allwinner H5 SoC has the same DMA engine with H3, the DMA

        ^^^ typo

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> driver should be allowed to be built for ARM64, in order to make it work on H5.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> New patch in v2, as H3 codec support is added between v1 and v2.
>
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 0d6a96ee9fc7..d01d59812cf3 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -157,7 +157,7 @@ config DMA_SUN4I
>
>  config DMA_SUN6I
>         tristate "Allwinner A31 SoCs DMA support"
> -       depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
> +       depends on MACH_SUN6I || MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>         depends on RESET_CONTROLLER
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
