From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Aug 2013 20:07:01 +0530
Subject: [PATCH 2/6] ARM: Tegra: Add CPU's OPPs for using cpufreq-cpu0
 driver
In-Reply-To: <1375971749.4276.61.camel@weser.hi.pengutronix.de>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <d4cd498d9b63d761039b025216e65278dc8e0e37.1375886595.git.viresh.kumar@linaro.org>
 <52028719.8070908@wwwdotorg.org>
 <CAKohpo=MpOyMGFTGeZWmoCRwmZ7+nQtP_yCGokPanEVYL0xbMw@mail.gmail.com>
 <52029811.9080704@wwwdotorg.org>
 <1375970318.4276.52.camel@weser.hi.pengutronix.de>
 <CAKohpon=GGn5-8ucTrrf6TyPMn3+1Oh6Sd5bAj_ztpVDONZ3QA@mail.gmail.com>
 <1375971749.4276.61.camel@weser.hi.pengutronix.de>
Message-ID: <CAKohpo=zYBVha_L7D+FWUEO=a6byeiuGtNBmh-CRhSmfkT=QrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2013 19:52, Lucas Stach <l.stach@pengutronix.de> wrote:
> You can certainly define the mapping table in DT where a specialized
> Tegra cpufreq driver could read it in and then map frequency to voltage.
> But that's a runtime decision, as Speedo and process ID are fuse values
> and can not be represented in DT.

> The problem with this is that the hardware description now associates
> voltages with certain frequencies and even if they are not used by the
> Linux driver they are plain wrong.

Hmm. I understand.
Then we probably need mach-tegra/opp.c to call opp_add() for all such
OPPs.. Neither DT nor cpufreq driver are the right place for this.
