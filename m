From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 14:55:50 -0500
Subject: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
In-Reply-To: <20180830180205.18121-1-krzk@kernel.org>
References: <20180830180205.18121-1-krzk@kernel.org>
Message-ID: <20180910195550.GA29719@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 08:02:05PM +0200, Krzysztof Kozlowski wrote:
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
> 
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
> 
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> [krzk: Explicitly list unstable bindings instead of marking entire
> Exynos]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> ---
> 
> Changes since v2:
> 1. Add tags.
> 
> Changes since v1:
> 1. Rebase
> 2. Add specific compatibles to mark unstable.
> 
> v1 is here:
> https://patchwork.kernel.org/patch/9477963/
> 
> Previous tags (not applying due to change in contents):
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/exynos.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos.txt

Feel free to take this thru the Samsung tree, but don't expect an ack 
from me.

Rob
