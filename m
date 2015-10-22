From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 11:05:29 +0200
Subject: [PATCH v2 1/3] dt-bindings: Consolidate SRAM bindings from all
 vendors
In-Reply-To: <1445477130-407-1-git-send-email-k.kozlowski@samsung.com>
References: <1445477130-407-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151022090529.GV10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 22, 2015 at 10:25:28AM +0900, Krzysztof Kozlowski wrote:
> SRAM bindings for various SoCs, using the mmio-sram genalloc
> API, are spread over different places - per SoC vendor. Since all of
> these are quite similar (they depend on mmio-sram) move them to a common
> place.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch. Extended suggestion from Rob.
> ---
>  .../bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt}    | 0
>  .../bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt}    | 0
>  .../bindings/{arm/exynos/smp-sysram.txt => sram/samsung-sram.txt}         | 0
>  Documentation/devicetree/bindings/{misc => sram}/sram.txt                 | 0
>  .../devicetree/bindings/{soc/sunxi/sram.txt => sram/sunxi-sram.txt}       | 0
>  5 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/rockchip/pmu-sram.txt => sram/rockchip-pmu-sram.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/rockchip/smp-sram.txt => sram/rockchip-smp-sram.txt} (100%)
>  rename Documentation/devicetree/bindings/{arm/exynos/smp-sysram.txt => sram/samsung-sram.txt} (100%)
>  rename Documentation/devicetree/bindings/{misc => sram}/sram.txt (100%)
>  rename Documentation/devicetree/bindings/{soc/sunxi/sram.txt => sram/sunxi-sram.txt} (100%)

I'm not sure about that one. The SRAM bindins we have for sunxi is for
an SRAM controller, that maps the SRAM either to the CPU or to the
devices.

It's not really related to the other users, and wouldn't it be
confusing to have a driver in drivers/soc, and a Documentation in
another sub-directory?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/0e623f79/attachment.sig>
