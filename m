From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Aug 2016 08:36:36 -0500
Subject: [PATCH v1 3/3] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
In-Reply-To: <1471315139-28285-4-git-send-email-finley.xiao@rock-chips.com>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-4-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20160819133636.GA26913@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:38:59AM +0800, Finlye Xiao wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch supports adjusting opp's voltage according to leakage
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  .../devicetree/bindings/power/rockchip-cpu-avs.txt |  37 +++
>  drivers/power/avs/Kconfig                          |   8 +
>  drivers/power/avs/Makefile                         |   1 +
>  drivers/power/avs/rockchip-cpu-avs.c               | 314 +++++++++++++++++++++
>  4 files changed, 360 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
>  create mode 100644 drivers/power/avs/rockchip-cpu-avs.c
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
> new file mode 100644
> index 0000000..90f6b08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
> @@ -0,0 +1,37 @@
> +Rockchip cpu avs device tree bindings
> +-------------------------------------
> +
> +Under the same frequency, the operating voltage tends to decrease with
> +increasing leakage. so it is necessary to adjust opp's voltage according
> +to leakage for power.
> +
> +
> +Required properties:
> +- compatible: Should be one of the following.
> +  - "rockchip,rk3399-cpu-avs" - for RK3399 SoCs.
> +- leakage-volt-<name>: Named leakage-volt property. At runtime, the
> +  platform can find a cpu's cluster_id according to it's cpu_id and match
> +  leakage-volt-<name> property. The property is an array of 3-tuples
> +  items, and each item consists of leakage and voltage like
> +  <min-leakage-mA max-leakage-mA vol-uV>.
> +	min-leakage: minimum leakage in mA.
> +	max-leakage: maximum leakage in mA.
> +	vol: voltage in microvolt.

How do you determine these values? When do they vary?

> +
> +Example:
> +
> +	cpu_avs: cpu-avs {
> +		compatible = "rockchip,rk3399-cpu-avs";

This isn't really a hardware block. For the same reasons we don't have 
cpufreq nodes. So I don't think this belongs in DT.

Rob
