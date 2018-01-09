From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Jan 2018 10:48:46 +0100
Subject: [PATCH v2 04/16] ARM: dtsi: axp209: add node for ADC
In-Reply-To: <d4de180d7f9555c3851f29a8c34d1f706cafd83e.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <d4de180d7f9555c3851f29a8c34d1f706cafd83e.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20180109094846.fubahuqk5f4yuzrm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 10:33:35AM +0100, Quentin Schulz wrote:
> This adds a DT node for the ADC of the PMIC so that there can be
> consumers of its IIO channels declaring their consumptions via DT.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 897103e..a2e0052 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -58,6 +58,11 @@
>  		status = "disabled";
>  	};
>  
> +	axp_adc: axp-adc {

The node nade should be adc.

> +		compatible = "x-powers,axp20x-adc";

And your compatible shouldn't have a wildcard but the first design
that introduced that IP.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/4db75619/attachment.sig>
