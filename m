From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Mar 2013 17:46:57 -0800
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
In-Reply-To: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
Message-ID: <20130307014657.GA7426@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
> +++ b/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
> @@ -0,0 +1,29 @@
> +Generic ARM big LITTLE cpufreq driver's DT glue
> +-----------------------------------------------
> +
> +It is DT specific glue layer for generic cpufreq driver for big LITTLE systems.
> +
> +Both required and optional properties listed below must be defined under node
> +cluster*. * can be 0 or 1.
> +
> +Required properties:
> +- freqs: List of all supported frequencies.
> +
> +Optional properties:
> +- clock-latency: Specify the possible maximum transition latency for clock, in
> +  unit of nanoseconds.
> +
> +Examples:
> +
> +cluster0: cluster at 0 {
> +        ..
> +
> +	freqs = <500000000 600000000 700000000 800000000 900000000 1000000000 1100000000 1200000000>;
> +	clock-latency = <200000>;
> +
> +	..
> +
> +        cores {
> +		..
> +        };
> +};

This binding makes no sense to me. It needs to be substantially better
documented, not just a couple of sentences that people that understand
bit.LITTLE thoroughly can make sense of.

It also duplicates the cpu binding. I suspect this should instead be done
through additions of the cpu bindings instead of duplication. So this needs to
be substantially reworked.


-Olof
