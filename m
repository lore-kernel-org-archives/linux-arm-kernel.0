From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 10:57:38 +0000
Subject: [PATCH V2 1/3] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <1487660104-15693-2-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487660104-15693-2-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <c47ce1ce-3e3f-ba5e-c45d-fd68d6cd5537@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 06:55, Chunyan Zhang wrote:
> From: Orson Zhai <orson.zhai@spreadtrum.com>
> 
> SC9860G is a 8 cores of A53 SoC with 4G LTE support SoC from Spreadtrum.
> 
> According to regular hierarchy of sprd dts, whale2.dtsi contains SoC
> peripherals IP nodes, sc9860.dtsi contains stuff related to ARM core stuff
> and sp9860g dts is for the board level.
> 
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm64/boot/dts/sprd/Makefile         |   3 +-
>  arch/arm64/boot/dts/sprd/sc9860.dtsi      | 531 ++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |  56 ++++
>  arch/arm64/boot/dts/sprd/whale2.dtsi      |  70 ++++
>  4 files changed, 659 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/sprd/sc9860.dtsi
>  create mode 100644 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
>  create mode 100644 arch/arm64/boot/dts/sprd/whale2.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
> new file mode 100644
> index 0000000..73deb4e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
> @@ -0,0 +1,531 @@
> +/*
> + * Spreadtrum SP9860 SoC DTS file
> + *
> + * Copyright (C) 2016, Spreadtrum Communications Inc.
> + *
> + * This file is licensed under a dual GPLv2 or X11 license.
> + */
> +

[...]

> +
> +	idle-states{
> +		entry-method = "arm,psci";
> +
> +		CORE_PD: core_pd {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <700>;
> +			min-residency-us = <2500>;
> +			local-timer-stop;
> +			arm,psci-suspend-param = <0x00010002>;
> +		};
> +
> +		CLUSTER_PD: cluster_pd {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <1000>;
> +			min-residency-us = <3000>;
> +			local-timer-stop;
> +			arm,psci-suspend-param = <0x01010003>;
> +		};

Thanks for dropping the hacked up "deep sleep" state :)
This version looks fine to me.

-- 
Regards,
Sudeep
