From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 26 May 2015 11:17:22 -0700
Subject: [PATCH v9 07/17] clk: tegra: Add Tegra124 DFLL clocksource
 platform driver
In-Reply-To: <1431529131-16710-8-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1431529131-16710-8-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <CAMAWPa8PQgNWbajvrxMiD4qcUBg+Q1xsOU5hhhFQbxE4VxW_uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 7:58 AM, Mikko Perttunen
<mikko.perttunen@kapsi.fi> wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> Add basic platform driver support for the fast CPU cluster DFLL
> clocksource found on Tegra124 SoCs. This small driver selects the
> appropriate Tegra124-specific characterization data and integration
> code. It relies on the DFLL common code to do most of the work.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> Acked-by: Michael Turquette <mturquette@linaro.org>

Various boot failures on non-tegra platforms (sunxi, omap) started
showing up in next-20150522, and still exist in next-20150525[1] and
today I bisected them down to this patch.

I didn't look closely, but I"m guessing the module_init() function
here needs some compatible checking so it's not actually executed on
non-tegra platforms.

I confirmed that reverting this patch on top of next-20150525 gets
both the sunxi and omap platforms booting again.

Kevin

[1] http://kernelci.org/boot/all/job/next/kernel/next-20150525/
