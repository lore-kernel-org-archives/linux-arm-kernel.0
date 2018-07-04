From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jul 2018 08:29:31 +0100
Subject: [PATCH 1/5] dt-bindings: mfd: axp20x: Add "self-working" mode
 for AXP806
In-Reply-To: <20180620051540.25617-2-wens@csie.org>
References: <20180620051540.25617-1-wens@csie.org>
 <20180620051540.25617-2-wens@csie.org>
Message-ID: <20180704072931.GG20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018, Chen-Yu Tsai wrote:

> The AXP806 has three operation modes:
> 
>   - master mode: The PMIC is the first or only AXP PMIC in the system,
> 		 but is not in charge of power management, i.e. only
> 		 provides regulator functions.
> 
>   - slave mode: The PMIC is the second AXP PMIC in the system, chained
> 		to the first, or master, one.
> 
>   - self-working mode: The PMIC is the only AXP PMIC in the system, and
> 		       is in charge of power sequencing.
> 
> The functional differences between these modes can be found in the
> "Control and Operation" chapter of the AXP806 (in Chinese) and AXP805
> (in English) datasheets. These include how the PMIC responds to external
> signals, whether it takes an external voltage reference or uses its own,
> and whether the EN/PWRON pin functions as an enable switch or power button.
> 
> We already support both slave and master mode. This patch adds a property
> for describing the self-working mode, and reworks the description for
> the mode properties.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
