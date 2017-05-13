From: briannorris@chromium.org (Brian Norris)
Date: Fri, 12 May 2017 17:53:36 -0700
Subject: [PATCH] arm64: dts: rockchip: Drop explicit "include/" prefix
 from #include
In-Reply-To: <20170512235357.19486-1-ijc@hellion.org.uk>
References: <20170512235357.19486-1-ijc@hellion.org.uk>
Message-ID: <20170513005335.GB23103@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 12:53:57AM +0100, Ian Campbell wrote:
> It not necessary and counter to how all the other files are done.
> 
> It also happens to break the build in the split device tree repo
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> 
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> index 658bb9dc9dfd..7bd31066399b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> @@ -44,7 +44,7 @@
>  
>  /dts-v1/;
>  #include "rk3399-gru.dtsi"
> -#include <include/dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/input/linux-event-codes.h>

Whoops, didn't catch that when porting this to mainline. Thanks!

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  
>  /*
>   * Kevin-specific things
> -- 
> 2.11.0
> 
