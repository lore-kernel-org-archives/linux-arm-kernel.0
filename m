From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 4 May 2015 08:00:19 +0200
Subject: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
In-Reply-To: <1430456052-8888-4-git-send-email-stripathi@apm.com>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
 <1430456052-8888-4-git-send-email-stripathi@apm.com>
Message-ID: <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2015 06:54 AM, Suman Tripathi wrote:
> This patch updates Arasan SDHC documentation to support
> 4.9a version of Arasan SDHC controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..f01d41a 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'arasan,sdhci-4.9a'           
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> @@ -18,7 +19,7 @@ Required Properties:
>  
>  Example:
>  	sdhci at e0100000 {
> -		compatible = "arasan,sdhci-8.9a";
> +		compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";

Is there any reason to change this example?
You probably want to have just one compatible string not both.

Thanks,
Michal
