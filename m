From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Jul 2014 13:18:39 +0100
Subject: [PATCH 09/19] ARM64 / ACPI: Move the initialization of
 cpu_logical_map(0) before acpi_boot_init()
In-Reply-To: <53D233CC.1070006@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-10-git-send-email-hanjun.guo@linaro.org>
 <20140724152103.GB26190@leverpostej> <53D233CC.1070006@linaro.org>
Message-ID: <20140725121839.GC19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 11:39:08AM +0100, Hanjun Guo wrote:
> On 2014-7-24 23:21, Mark Rutland wrote:
> > On Thu, Jul 24, 2014 at 02:00:15PM +0100, Hanjun Guo wrote:
> >> Move the initialization of cpu_logical_map(0) before acpi_boot_init()
> >> to remove the duplicated initialization of cpu_logical_map(0).
> > 
> > It always make sense to initialise CPU0's logical map entry from the
> > hardware values, so you could do this earlier in the series, before you
> > introduce any ACPI code. Then you don't have the churn in acpi.c
> 
> ok, I will prepare a separate patch to do this before ACPI code, does it
> make sense to you?

Yes. Just put that at the start of the series.

Thanks,
Mark.
