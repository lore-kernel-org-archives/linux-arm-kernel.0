From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Apr 2016 12:00:09 -0500
Subject: [PATCH v2 2/4] Documentation: Add documentation for APM X-Gene
 SoC PMU DTS binding
In-Reply-To: <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
 <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
Message-ID: <20160418170009.GA15338@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 06:22:25PM -0700, Tai Nguyen wrote:
> Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
> 
> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
> ---
>  .../devicetree/bindings/perf/apm-xgene-pmu.txt     | 116 +++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
> new file mode 100644
> index 0000000..40dfd4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
> @@ -0,0 +1,116 @@
> +* APM X-Gene SoC PMU bindings
> +
> +This is APM X-Gene SoC PMU (Performance Monitoring Unit) module.
> +The following PMU devices are supported:
> +
> +  L3C			- L3 cache controller
> +  IOB			- IO bridge
> +  MCB			- Memory controller bridge
> +  MC			- Memory controller
> +
> +The following section describes the SoC PMU DT node binding.
> +
> +Required properties:
> +- compatible		: Shall be "apm,xgene-pmu" for revision 1 or
> +                          "apm,xgene-pmu-v2" for revision 2.
> +- regmap-csw		: Regmap of the CPU switch fabric (CSW) resource.
> +- regmap-mcba		: Regmap of the MCB-A (memory bridge) resource.
> +- regmap-mcbb		: Regmap of the MCB-B (memory bridge) resource.
> +- reg			: First resource shall be the CPU bus PMU resource.
> +- interrupts            : Interrupt-specifier for PMU IRQ.
> +
> +Required properties for L3C subnode:
> +- compatible		: Shall be "apm,xgene-pmu-l3c".
> +- reg			: First resource shall be the L3C PMU resource.
> +- index			: Instance number of the L3C PMU.
> +
> +Required properties for IOB subnode:
> +- compatible		: Shall be "apm,xgene-pmu-iob".
> +- reg			: First resource shall be the IOB PMU resource.
> +- index			: Instance number of the IOB PMU.
> +
> +Required properties for MCB subnode:
> +- compatible		: Shall be "apm,xgene-pmu-mcb".
> +- reg			: First resource shall be the MCB PMU resource.
> +- index			: Instance number of the MCB PMU.
> +
> +Required properties for MC subnode:
> +- compatible		: Shall be "apm,xgene-pmu-mc".
> +- reg			: First resource shall be the MC PMU resource.
> +- index			: Instance number of the MC PMU.

Don't use indexes. You probably need phandles to the nodes these are 
related to.

How many variations of child nodes do you expect to have? 2, 10, 50? You 
might want to just collapse all this down to a single node and put this 
information in the driver if it is fixed for each SoC and there's only a 
handful.

Rob
