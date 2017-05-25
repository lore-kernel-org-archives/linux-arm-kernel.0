From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 25 May 2017 12:34:28 +0100
Subject: [PATCH 2/4] arm64: dts: mt7622: add basic nodes to the
 mt7622.dtsi file
In-Reply-To: <cf3a0264cff770f60235d3be83cef00981ba6d33.1495703415.git.sean.wang@mediatek.com>
References: <cover.1495703415.git.sean.wang@mediatek.com>
 <cf3a0264cff770f60235d3be83cef00981ba6d33.1495703415.git.sean.wang@mediatek.com>
Message-ID: <e2efffae-a2ba-c67e-b1b3-cc7413ae83f7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/17 10:28, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add basic nodes into the mt7622.dtsi for the system
> bring-up which includes ARM CPU, GIC, timer, MediaTek
> UART, SYSIRQ and one reserved memory region for ATF.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 103 +++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7622.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> new file mode 100644
> index 0000000..f610d30
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: Ming Huang <ming.huang@mediatek.com>
> + *	   Sean Wang <sean.wang@mediatek.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "mediatek,mt7622";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;

Just note that cache geometry detection from architected registers are
removed from v4.12 and hence needs to be specified in DT if you expect
it to show up in sysfs.
-- 
Regards,
Sudeep
