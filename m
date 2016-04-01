From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Apr 2016 13:30:01 +0100
Subject: [PATCH 2/4] Documentation: Add documentation for APM X-Gene SoC
 PMU DTS binding
In-Reply-To: <1459467472-31561-3-git-send-email-ttnguyen@apm.com>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
 <1459467472-31561-3-git-send-email-ttnguyen@apm.com>
Message-ID: <20160401123000.GC29876@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As per Documentation/devicetree/bindings/submitting-patches.txt, please
put binding patches earlier in a series than the code using them.

On Thu, Mar 31, 2016 at 04:37:50PM -0700, Tai Nguyen wrote:
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

These sound like separate units. How do these relate?

Is there an SOC-wide PMU that aggregates counters, or are these actually
independent?

> +
> +The following section describes the SoC PMU DT node binding.
> +
> +Required properties:
> +- compatible		: Shall be "apm,xgene-pmu" for revision 1 or
> +                          "apm,xgene-pmu-v2" for revision 2.

That name is very general. Is there not a more specific name for the SOC
PMU?

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

What's the index property useful for?

Thanks,
Mark.
