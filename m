From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 Nov 2016 20:26:09 +0200
Subject: [RESEND PATCH v1 05/11] dt-bindings: perf: hisi: Add Devicetree
 bindings for Hisilicon SoC PMU
In-Reply-To: <1478151727-20250-6-git-send-email-anurup.m@huawei.com>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
 <1478151727-20250-6-git-send-email-anurup.m@huawei.com>
Message-ID: <20161103182609.GA11071@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 01:42:01AM -0400, Anurup M wrote:
> 	1) Device tree bindings for Hisilicon SoC PMU.
> 	2) Add example for Hisilicon L3 cache, MN and DDRC PMU.

Get rid of this weird indentation in all patches.


> 
> Signed-off-by: Anurup M <anurup.m@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  .../devicetree/bindings/arm/hisilicon/pmu.txt      | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
> new file mode 100644
> index 0000000..e7b35e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
> @@ -0,0 +1,127 @@
> +Hisilicon SoC hip05/06/07 ARMv8 PMU
> +===================================
> +
> +The Hisilicon SoC chips like hip05/06/07 etc. consist of varous independent
> +system device PMU's such as L3 cache (L3C), Miscellaneous Nodes(MN) and DDR
> +comtroller. These PMU devices are independent and have hardware logic to
> +gather statistics and performance information.
> +
> +HiSilicon SoC chip is encapsulated by multiple CPU and IO die's. The CPU die
> +is called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
> +is further grouped as CPU clusters (CCL) which includes 4 cpu-cores each.
> +e.g. In the case of hip05/06/07, each SCCL has 1 L3 cache and 1 MN PMU device.
> +
> +The Hisilicon SoC PMU DT node bindigs for uncore PMU devices are as below.
> +For PMU devices like L3 cache. MN etc. which are accessed using the djtag,
> +the parent node will be the djtag node of the corresponding CPU die(SCCL).
> +
> +For uncore PMU devices there are some common required properties as detailed
> +below.
> +
> +Required properties:
> +	- compatible : This field contain two values. The first value is
> +		always "hisilicon" and second value is the Module type as shown
> +		in below examples:

Over-complicated sentence. Just:

	- compatible : One of:
		"hisilicon,hisi-pmu-l3c-v1" for Hisilicon SoC L3C PMU
			device (Version 1)
		...
		...

BTW, No need of CC-ing me. I am not a maintainer of relevant subsystems.

Best regards,
Krzysztof
