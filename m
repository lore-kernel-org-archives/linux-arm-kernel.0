From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:28:41 +0000
Subject: [PATCH 05/14] dt-bindings: mfd: axp20x: add support for
 regulator-ramp-delay for AXP209
In-Reply-To: <4333f81dfa1d9be082b09ab9ddf2694cb56285e2.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <4333f81dfa1d9be082b09ab9ddf2694cb56285e2.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181128092841.GY4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The AXP209 supports ramping up voltages on several regulators such as
> DCDC2 and LDO3, therefore we can use the standard 'regulator-ramp-delay'
> property for those 2 regulators.
> 
> Note that the voltage ramp only works when the regulator is already
> enabled. E.g. when going from say 0.7 V to 3.6 V.
> 
> When turning on the regulator, no voltage ramp is performed in hardware.
> 
> What this means, is that if the bootloader brings up the voltage at 0.7 V,
> the ramp delay property is properly applied. If however, the bootloader
> leaves the power off, no ramp delay is applied when the power is
> enabled by the regulator framework.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 188f037..5542212 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -32,6 +32,11 @@ Required properties:
>  - interrupt-controller: The PMIC has its own internal IRQs
>  - #interrupt-cells: Should be set to 1
>  
> +Supported common regulator properties, see regulator.txt for more information:

regulator.txt should be a relative path.

../regulator/regulator.txt in this case.

Once changed, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
