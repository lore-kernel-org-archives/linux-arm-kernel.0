From: brendan.jackman@arm.com (Brendan Jackman)
Date: Thu, 4 Aug 2016 16:29:00 +0100
Subject: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
In-Reply-To: <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160804152900.GC1732@brendan-thinkstation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lina,

Sorry, forgot to mention this in my other email:

On Fri, Jul 29, 2016 at 03:56:13PM -0600, Lina Iyer wrote:
>
> +Example 3:
> +
> +	pm-domains {
> +		a57_pd: a57_pd@ {
> +			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a57";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>;
> +		};
> +
> +		a53_pd: a53_pd@ {
> +			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a53";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
> +		};
> +
> +		CLUSTER_SLEEP_0: idle-state at 0 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <2000>;
> +			residency-us = <10000>;

Existing bindings for CPU idle states use "min-residency-us" instead of
"residency-us" here.

> +		};
> +
> +		CLUSTER_SLEEP_1: idle-state at 1 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <5000>;
> +			exit-latency-us = <5000>;
> +			residency-us = <100000>;
> +		};
> +	};

Regards,
Brendan
