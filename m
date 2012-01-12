From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jan 2012 16:23:01 +0800
Subject: [PATCH V6 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <87aa5t25ad.fsf@ti.com>
References: <1325213769-11752-1-git-send-email-richard.zhao@linaro.org>
 <1325213769-11752-5-git-send-email-richard.zhao@linaro.org>
 <87aa5t25ad.fsf@ti.com>
Message-ID: <20120112082300.GF2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 03:22:34PM -0800, Kevin Hilman wrote:
> Richard Zhao <richard.zhao@linaro.org> writes:
> 
> > The driver get cpu operation point table from device tree cpu0 node,
> 
> Since we already have an existing OPP infrastructure in the kernel,
> seems like  this driver should get OPPs by asking the OPP layer.
When I created the patch, there's only omap cpufreq driver using
OPP. If it depends on OPP, it might prevent users who have not
adopted OPP from using the driver.
> 
> This approach assumes the OPP layer is static at boot time and not
> changing, however that's not the case in practice.
> 
> The OPP layer could be extended to read boot-time OPPs from DT if
> desired, but since the OPPs are also populated/enabled/disabled
> dynamicaly on some platforms (e.g. OMAP), I think the any generic
> CPUfreq driver should use the OPP interface and not DT directly.
> 
> > and adjusts operating points using clk and regulator APIs.
> 
> For a generic driver, the regulator used should also be configurable.
> 
> For example, this driver currently assumes a regulator named "cpu" for
> all instances.   If you had separate clusters with independent voltage
> control, you'd likely have a separate regulator for each cluster.
The driver, for now, assumes all cpu cores uses the same clk and voltage.
It's correct for most arm multi-core SoC.
Do you have real case to need different voltage/clk?
And the regulator will be specified in dts after cpu convert from sys
device to normal device.

Thanks
Richard
> 
> Kevin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
