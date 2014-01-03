From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 3 Jan 2014 12:26:25 +0530
Subject: [BUG] cpufreq: bL_switcher can fail to build
In-Reply-To: <20140102172102.GA7383@n2100.arm.linux.org.uk>
References: <20140102172102.GA7383@n2100.arm.linux.org.uk>
Message-ID: <CAOh2x=kS+t141WKmr2Unawj1h3Y7MkA8NB6Z+bayqXXsVNk_Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 10:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> The randconfig results from the autobuilder produced this error for
> the big.LITTLE cpufreq code for the omap4430-sdp randconfig build on
> New Years day.
>
> drivers/built-in.o: In function `bL_cpufreq_set_rate':
> powercap_sys.c:(.text+0x5ed9a0): undefined reference to `bL_switch_request_cb'
>
> Maybe CONFIG_ARM_BIG_LITTLE_CPUFREQ needs to depend on CONFIG_BIG_LITTLE ?

Yeah. The time this driver got added we didn't had this CONFIG option.
But we missed pushing it along with big LITTLE support. I will push
a patch for this through cpufreq tree.

--
viresh
