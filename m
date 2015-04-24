From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 24 Apr 2015 08:56:39 +0200
Subject: [PATCH] ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name
In-Reply-To: <1429845411-9280-1-git-send-email-marex@denx.de>
References: <1429845411-9280-1-git-send-email-marex@denx.de>
Message-ID: <5539E927.3080205@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Am 24.04.2015 um 05:16 schrieb Marek Vasut:
> Fix a typo in the TX DMA interrupt name for AUART4.
> This patch makes AUART4 operational again.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/boot/dts/imx28.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> NOTE: This bug goes all the way back to at least Linux 3.10
> NOTE: I am not the author of the patch, but I am not allowed to disclose
>       the name of the original author due to the circumstances.
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 25e25f8..4e073e8 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -913,7 +913,7 @@
>  					      80 81 68 69
>  					      70 71 72 73
>  					      74 75 76 77>;
> -				interrupt-names = "auart4-rx", "aurat4-tx", "spdif-tx", "empty",
> +				interrupt-names = "auart4-rx", "auart4-tx", "spdif-tx", "empty",
>  						  "saif0", "saif1", "i2c0", "i2c1",
>  						  "auart0-rx", "auart0-tx", "auart1-rx", "auart1-tx",
>  						  "auart2-rx", "auart2-tx", "auart3-rx", "auart3-tx";

looks good, but shouldn't we patch also the wrong documentation?

Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt

Best regards
Stefan
