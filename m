From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Dec 2015 18:23:11 +0100
Subject: [PATCH v2] cpufreq: i.MX6: -EPROBE_DEFER fixes
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1449854591.29174.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 28.10.2015, 08:59 +0100 schrieb Sascha Hauer:
> The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
> regulator_get/clk_get. This series fix that and some other small
> issues.
> 
> Shawn, Could you give me your ack for patch 4/5?
> 
> Sascha
> 
What's the status of this series? I think I only had some minor
comments on the last round. Can you please fix those and resend the
series? It would be a shame if this misses 4.5, as it includes some
really nice cleanups and fixes.

Regards,
Lucas

> Changes since v1:
> 
> - Fix Coding style nitpicks
> - drop unnecessary platform_device argument from
> ? imx6q_cpufreq_get_resources
> - Add more comments
> - Use id_table to distinguish between SoCs
> - make PU regulator non optional on SoCs that need it and don't
> request
> ? it on SoCs that don't need it
> 
> ----------------------------------------------------------------
> Sascha Hauer (5):
> ??????cpufreq: imx6q: Fix goto wrong error label
> ??????cpufreq: imx6q: Fix wrong device in devm_kzalloc
> ??????cpufreq: imx6q: Fix regulator/clock error handling
> ??????cpufreq: imx6q: Use id_table to distinguish between SoCs
> ??????cpufreq: imx6q: pu regulator is not optional
> 
> ?arch/arm/mach-imx/mach-imx6sl.c |???2 +-
> ?arch/arm/mach-imx/mach-imx6sx.c |???2 +-
> ?arch/arm/mach-imx/mach-imx6ul.c |???2 +-
> ?drivers/cpufreq/imx6q-cpufreq.c | 213 ++++++++++++++++++++++++++--
> ------------
> ?4 files changed, 145 insertions(+), 74 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at??http://vger.kernel.org/majordomo-info.html
