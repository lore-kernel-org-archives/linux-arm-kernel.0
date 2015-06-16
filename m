From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 16 Jun 2015 11:17:53 -0700
Subject: [PATCH 5/5] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <1433839623-10804-6-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Tue, 9 Jun 2015 10:47:03 +0200")
References: <1433839623-10804-1-git-send-email-s.hauer@pengutronix.de>
 <1433839623-10804-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7hlhfjy0tq.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> This adds the SCPSYS device node to the MT8173 dtsi file.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 924fdb6..12430f0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -125,6 +125,16 @@
>  						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		scpsys: scpsys at 10006000 {
> +			compatible = "mediatek,mt8173-scpsys";
> +			#power-domain-cells = <1>;
> +			reg = <0 0x10006000 0 0x1000>;
> +			clocks = <&clk26m>,
> +				 <&topckgen CLK_TOP_MM_SEL>;

Neither your binding doc (nor the generic one) mentions these clock
properties or what they are used for.  They appear to define a clock
that must be enabled in order to for the power domain to be on.

Also the order here seems rather important and probably needs
documenting in the binding (e.g. the clk_id order is hard-coded in the
driver.)

Kevin
