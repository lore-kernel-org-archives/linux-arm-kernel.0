From: mporter@ti.com (Matt Porter)
Date: Fri, 7 Sep 2012 08:59:36 -0400
Subject: [PATCH RESEND] arm/dts: AM33XX: Add SPI device tree data
In-Reply-To: <1346914815-860-1-git-send-email-avinashphilip@ti.com>
References: <1346914815-860-1-git-send-email-avinashphilip@ti.com>
Message-ID: <20120907125936.GH27758@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 12:30:15PM +0530, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> Resenting patch because ARM & OMAP mailing list was not copied.
> 
> :100644 100644 bb31bff... 6b469bd... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bb31bff..6b469bd 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -210,5 +210,30 @@
>  			interrupt-parent = <&intc>;
>  			interrupts = <91>;
>  		};
> +
> +		spi0: spi at 48030000 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x4830000 0x400>;

Please fix this typo, should be 0x48030000.

With the typo fixed, it's working on bone for me:

Tested-by: Matt Porter <mporter@ti.com>

-Matt
