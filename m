From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Oct 2017 11:50:18 +0100
Subject: [PATCH 2/7] regulator: axp20x: Add support for AXP813 regulators
In-Reply-To: <20170929032514.31727-3-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
 <20170929032514.31727-3-wens@csie.org>
Message-ID: <20171004105018.oxwhialssxh62sv3@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Sep 2017, Chen-Yu Tsai wrote:

> The AXP813 PMIC has 7 DC-DC buck regulators, 16 LDOs (including the
> fixed RTC LDO and 2 GPIO LDOs), and 1 switchable. The drive-vbus
> feature is also supported. All the hardware details are very similar
> to the AXP803, with the following exceptions:
> 
>   - Extra DCDC7 buck regulator, with the same range as DCDC6
> 
>   - SWitch now has a separate supply pin, instead of being chained
>     internaly from DCDC1
> 
>   - RTC LDO output voltage is now 1.8V
> 
>   - FLDO3 is an LDO with switchable supplies, but unconfigurable output
>     voltage. The voltage is always half that of its supply.
> 
> Support for FLDO3 is currently unimplemented, as it requires runtime
> switching of its supplies, something the regulator subsystem does not
> support. It is not used in either the reference designs nor actually
> produced boards available.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 102 +++++++++++++++++++++++++++++++++--

>  include/linux/mfd/axp20x.h           |   3 ++

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 101 insertions(+), 4 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
