From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 16:17:09 +0800
Subject: [PATCH 06/22] arm/dts: i.MX25: Add ssi clocks and DMA events.
In-Reply-To: <1373900227-341-7-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-7-git-send-email-denis@eukrea.com>
Message-ID: <20130716081703.GF30067@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:56:51PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index b318106..fb37111 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -293,6 +293,9 @@
>  				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
>  				reg = <0x50014000 0x4000>;
>  				interrupts = <11>;
> +				clocks = <&clks 118>;
> +				clock-names = "ssi2_ipg";
> +				fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */

The imx-sdma driver adopts generic DMA bindings since v3.11-rc1.  I just
sent a patch [1] to update DTS for that.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg258803.html
