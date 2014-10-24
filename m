From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 23 Oct 2014 17:48:11 -0700
Subject: [PATCH v13 3/5] ARM: dts: add RK3288 Thermal data
In-Reply-To: <1414057207-1576-4-git-send-email-caesar.wang@rock-chips.com>
References: <1414057207-1576-1-git-send-email-caesar.wang@rock-chips.com>
 <1414057207-1576-4-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <20141024004811.GE9463@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

On Thu, Oct 23, 2014 at 05:40:05PM +0800, Caesar Wang wrote:
> This patch changes a dtsi file to contain the thermal data
> on RK3288 and later SoCs. This data will
> enable a thermal shutdown over 125C.
> 
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288-thermal.dtsi | 65 +++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi
> 
> diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/dts/rk3288-thermal.dtsi
> new file mode 100644
> index 0000000..c361262
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-thermal.dtsi
> @@ -0,0 +1,65 @@
> +/*
> + * Device Tree Source for RK3288 SoC thermal
> + *
> + * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +reserve_thermal: reserve_thermal {
> +	polling-delay-passive = <500>; /* milliseconds */
> +	polling-delay = <1000>; /* milliseconds */
> +
> +			/* sensor	ID */
> +	thermal-sensors = <&tsadc	0>;
> +
> +};
> +
> +cpu_thermal: cpu_thermal {
> +	polling-delay-passive = <500>; /* milliseconds */
> +	polling-delay = <1000>; /* milliseconds */

Given that the hardware supports alarm interrupts I think we should be
able to lower polling frequency. I'd say 5 seconds for polling-delay and
1 second for when we trip over passive point?

Thanks.

-- 
Dmitry
