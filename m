From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 28 Apr 2015 11:42:48 -0700
Subject: [PATCH 05/11] ARM: imx6: set initial power mode in pm function
In-Reply-To: <1430058672-9267-6-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
 <1430058672-9267-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMAWPa8cyybpdgO+Po=7YUnCFkrnyHKKihgddzrUpHfAW=7brA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sun, Apr 26, 2015 at 7:31 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Rather than setting initial low-power mode in every single i.MX6 clock
> initialization function, we should really do that in pm code.  Let's
> move imx6q_set_lpm(WAIT_CLOCKED) call into imx6_pm_common_init().
>
> While at it, let's rename the function to imx6_set_lpm() since it's
> actually common for all i.MX6 SoCs.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Some boot failures on imx6[1] (multi_v7_defconfig) were bisected down
to this patch.  A simple revert doesn't build, so I was unable tot
test a direct revert.  However, from the boot failures you can see
that while multi_v7_defconfig boots fail, the imx_v6_v7_defconfig
boots fine.  Disabling CONFIG_CPU_IDLE in multi_v7_defconfig allows
this to start booting again on my wandboard quad, so I think there is
something wrong with the cpuidle changes.

Kevin

[1] http://kernelci.org/boot/?next-20150428&imx6
