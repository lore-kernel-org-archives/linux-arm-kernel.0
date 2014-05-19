From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 May 2014 13:32:30 +0100
Subject: [PATCH 1/3] Documentation: Update Arasan SDHC documentation for
 the APM X-Gene SoC SDHC DTS binding
In-Reply-To: <1400398918-1502-2-git-send-email-lho@apm.com>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
 <1400398918-1502-2-git-send-email-lho@apm.com>
Message-ID: <20140519123230.GA3663@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 08:41:56AM +0100, Loc Ho wrote:
> This patch updates Arasan SDHC documentation for the APM X-Gene SoC SDHC controller
> DTS binding.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..8fc4cc4 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,14 +8,17 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'xgene,arasan,sdhci-8.9a'

"xgene" is not a vendor, nor is it documented as such.

>    - reg: From mmc bindings: Register location and length.
> -  - clocks: From clock bindings: Handles to clock inputs.
> -  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>    - interrupts: Interrupt specifier
>    - interrupt-parent: Phandle for the interrupt controller that services
>  		      interrupts for this device.
>  
> +Optional Properties:
> +  - clocks: From clock bindings: Handles to clock inputs.
> +  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"

Given that these used to be required, they are presumably still required
in some cases?

If we're going to alter these lines, it'd be nice to clean them up at
the same time (a list is not a tuple, clocks aren't just phandles).

Cheers,
Mark.
