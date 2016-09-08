From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Sep 2016 09:09:09 +0530
Subject: [PATCH v2 2/2] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
In-Reply-To: <57D02C85.7020300@ti.com>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-3-d-gerlach@ti.com>
 <20160907052053.GO27345@vireshk-i7> <57D02C85.7020300@ti.com>
Message-ID: <20160908033909.GR27345@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-09-16, 10:04, Dave Gerlach wrote:
> >>+static const struct of_device_id ti_cpufreq_of_match[] = {
> >>+	{ .compatible = "operating-points-v2-ti-am3352-cpu",
> >>+	  .data = &am3x_soc_data, },
> >>+	{ .compatible = "operating-points-v2-ti-am4372-cpu",
> >>+	  .data = &am4x_soc_data, },
> >>+	{ .compatible = "operating-points-v2-ti-dra7-cpu",
> >>+	  .data = &dra7_soc_data },
> >
> >You should be using your SoC compatible strings here. OPP compatible
> >property isn't supposed to be (mis)used for this purpose.
> >
> 
> Referring to my comments in patch 1, what if we end up changing the bindings
> based on DT maintainer comments? We will have these compatible strings, and
> at that point is it acceptable to match against them? Or is it still better
> to match to SoC compatibles? I think it makes sense to just probe against
> these.

But even then I think these are not correct. You should have added a
single compatible string: operating-points-v2-ti-cpu.

As the properties will stay the same across machines. And then you
need to use SoC strings here.

-- 
viresh
