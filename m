From: luka@openwrt.org (Luka Perkov)
Date: Mon, 19 Aug 2013 14:35:42 +0200
Subject: [PATCH] ARM: dts: imx6sl reuses imx6q sdma firmware
In-Reply-To: <1376903386-27771-1-git-send-email-shawn.guo@linaro.org>
References: <1376903386-27771-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130819123541-7656@mutt-kz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Aug 19, 2013 at 05:09:46PM +0800, Shawn Guo wrote:
> There is no imx6sl specific sdma firmware.  Instead, imx6sl reuses
> imx6q sdma firmware.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index c46651e..9fec772 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -619,7 +619,8 @@
>  					 <&clks IMX6SL_CLK_SDMA>;
>  				clock-names = "ipg", "ahb";
>  				#dma-cells = <3>;
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
> +				/* imx6sl reuses imx6q sdma firmware */
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";

As you may have noticed my patch changes both imx6sl.dtsi and
imx6qdl.dtsi because of the naming convention used in other sdma
firmwares:

$ fgrep sdma-ram-script-name arch/arm/boot
arch/arm/boot/dts/imx6qdl.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
arch/arm/boot/dts/imx6sl.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
arch/arm/boot/dts/imx51.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
arch/arm/boot/dts/imx53.dtsi:				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";

Also, last patch containing sdma firmware blobs sent to the mailing list
[1] uses "sdma-imx6.bin" name. That is why I think patch I have sent
recently [2] is more appropriate. Don't you think so?

Luka

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143025.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191108.html
