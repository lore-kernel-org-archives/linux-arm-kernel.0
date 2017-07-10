From: oliver@schinagl.nl (Olliver Schinagl)
Date: Mon, 10 Jul 2017 13:44:18 +0200
Subject: [linux-sunxi] [PATCH v5 6/6] ARM: sun4i: Convert to CCU
In-Reply-To: <796d0ecb0fe0204891387910b8222bfa43a93326.1499197129.git-series.plaes@plaes.org>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
 <796d0ecb0fe0204891387910b8222bfa43a93326.1499197129.git-series.plaes@plaes.org>
Message-ID: <c52b7297-76c6-1f87-e87d-149a3f469bef@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pritt,

On 04-07-17 22:05, Priit Laes wrote:
> Convert sun4i-a10.dtsi to new CCU driver.
>
> Tested on Gemei G9 tablet.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 646 +++-----------------------------
>  1 file changed, 73 insertions(+), 573 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 41c2579..fc23c41 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -45,7 +45,6 @@
>
>  #include <dt-bindings/thermal/thermal.h>
>
> -#include <dt-bindings/clock/sun4i-a10-pll2.h>
>  #include <dt-bindings/dma/sun4i-a10.h>

I think the same includes are missing here as well?

Olliver
