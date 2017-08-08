From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 08 Aug 2017 20:36:35 +0800
Subject: [PATCH v3 1/4] Documentation: devicetree: add binding for
 Broadcom STB AVS TMON
In-Reply-To: <20170731192633.58747-2-code@mmayer.net>
References: <20170731192633.58747-1-code@mmayer.net>
 <20170731192633.58747-2-code@mmayer.net>
Message-ID: <1502195795.4296.37.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-07-31 at 12:26 -0700, Markus Mayer wrote:
> From: Brian Norris <computersforpeace@gmail.com>
> 
> Add binding for Broadcom STB thermal.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

$ file v3-1-4-Documentation-devicetree-add-binding-for-Broadcom-STB-
AVS-TMON.patch?
unified diff output, UTF-8 Unicode text

BTW, can you please rebase this patch set on top of v4.13-rc3?
At least there are some conflicts in MAINTAINER file, introduced in
-rc2.

thanks,
rui
> ---
> ?.../devicetree/bindings/thermal/brcm,avs-tmon.txt????| 20
> ++++++++++++++++++++
> ?MAINTAINERS??????????????????????????????????????????|??8 ++++++++
> ?2 files changed, 28 insertions(+)
> ?create mode 100644
> Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-
> tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-
> tmon.txt
> new file mode 100644
> index 0000000..9d43553
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
> @@ -0,0 +1,20 @@
> +* Broadcom STB thermal management
> +
> +Thermal management core, provided by the AVS TMON hardware block.
> +
> +Required properties:
> +- compatible: must be "brcm,avs-tmon" and/or "brcm,avs-tmon-bcm7445"
> +- reg: address range for the AVS TMON registers
> +- interrupts: temperature monitor interrupt, for high/low threshold
> triggers
> +- interrupt-names: should be "tmon"
> +- interrupt-parent: the parent interrupt controller
> +
> +Example:
> +
> +	thermal at f04d1500 {
> +		compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-
> tmon";
> +		reg = <0xf04d1500 0x28>;
> +		interrupts = <0x6>;
> +		interrupt-names = "tmon";
> +		interrupt-parent = <&avs_host_l2_intc>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205d397..a683d4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2928,6 +2928,14 @@ S:	Maintained
> ?F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-
> cpu-freq.txt
> ?F:	drivers/cpufreq/brcmstb*
> ?
> +BROADCOM STB AVS TMON DRIVER
> +M:	Markus Mayer <mmayer@broadcom.com>
> +M:	bcm-kernel-feedback-list at broadcom.com
> +L:	linux-pm at vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/brcm,avs-
> tmon.txt
> +F:	drivers/thermal/broadcom/brcmstb*
> +
> ?BROADCOM SPECIFIC AMBA DRIVER (BCMA)
> ?M:	Rafa? Mi?ecki <zajec5@gmail.com>
> ?L:	linux-wireless at vger.kernel.org
