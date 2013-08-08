From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Aug 2013 08:03:33 +0530
Subject: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same
 as current
In-Reply-To: <2331427.ybQdfvflPh@vostro.rjw.lan>
References: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
 <52022FC2.2010109@arm.com>
 <CAKohpom0gPk9BXRP2eEuX_HBXDut=wynrZfvOH1tcEQY6CMLNQ@mail.gmail.com>
 <2331427.ybQdfvflPh@vostro.rjw.lan>
Message-ID: <CAKohpokdvJxcWjbOgDLAzjcW_vN6hdZz_OWjFSBSLrFTccCmJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2013 04:55, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> It looks like it would require us to redefine .target() to take next_state
> instead of target_freq (at least in the acpi-cpufreq case), wouldn't it?

If we don't do it, then atleast for few drivers, like acpi-cpufreq, which
use index more than just for frequency, we may end up calling
cpufreq_frequency_table_target() twice. Once in the core and then
in driver.

I believe this is doable and will post a patch soon.
