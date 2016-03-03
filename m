From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 17:40:52 -0600
Subject: [PATCH] ARM: realview: add EB syscon variants to bindings
In-Reply-To: <1456218606-3749-1-git-send-email-linus.walleij@linaro.org>
References: <1456218606-3749-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160303234052.GA15598@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 10:10:06AM +0100, Linus Walleij wrote:
> There are two distinct RealView EB system controller that we need
> to detect and handle because their register layout differ
> slightly.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/arm/arm-boards | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
> index 2daeabc519de..7b05fc936d23 100644
> --- a/Documentation/devicetree/bindings/arm/arm-boards
> +++ b/Documentation/devicetree/bindings/arm/arm-boards
> @@ -131,7 +131,9 @@ Required nodes:
>  
>  - syscon: some subnode of the RealView SoC node must be a
>    system controller node pointing to the control registers,
> -  with the compatible string set to one of these tuples:
> +  with the compatible string set to one of these:
> +   "arm,realview-eb11mp-revb-syscon", "arm,realview-eb-syscon", "syscon"
> +   "arm,realview-eb11mp-revc-syscon", "arm,realview-eb-syscon", "syscon"
>     "arm,realview-eb-syscon", "syscon"
>     "arm,realview-pb1176-syscon", "syscon"
>     "arm,realview-pb11mp-syscon", "syscon"
> -- 
> 2.4.3
> 
