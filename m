From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 27 Mar 2015 10:02:01 +0800
Subject: [PATCH v2] cpufreq: hisilicon: add acpu driver
In-Reply-To: <55141412.6040600@arm.com>
References: <1427370486-14823-1-git-send-email-leo.yan@linaro.org>
 <55141412.6040600@arm.com>
Message-ID: <20150327020201.GB4902@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Sudeep,

Thanks for reviewing.

On Thu, Mar 26, 2015 at 02:13:38PM +0000, Sudeep Holla wrote:
> 
> On 26/03/15 11:48, Leo Yan wrote:
> >+static int __init hisi_acpu_cpufreq_driver_init(void)
> >+{
> >+	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> >+	struct platform_device *pdev;
> >+
> >+	if (!of_machine_is_compatible("hisilicon,hi6220"))
> >+		return -ENODEV;
> >+
> >+	pdev = platform_device_register_full(&devinfo);
> >+	return PTR_ERR_OR_ZERO(pdev);
> 
> Since you are not using anything other than name, you can simplify it
> further by something like:
> 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0)

Will use this way and resend patch.

> And IMO it need not be a separate driver too, you can add this in mach
> if it exists(i.e. arm32 though not recommended) or clock code that
> registers cpu clock. Thoughts ?

This driver will be firstly used for hikey board w/t ARMv8 SoC and i
prefer de-couple the cpufreq driver w/t clk driver. w/t this cpufreq
driver, we can easily enhance it and init SoC's specific operations
for later more hisilicon SoCs.

Thanks,
Leo Yan
