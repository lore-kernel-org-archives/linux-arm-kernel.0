From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 13 Aug 2018 10:25:41 +0200
Subject: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for
 rk3399
In-Reply-To: <ae312dc3-f640-ecf3-049a-c8576bb83330@rock-chips.com>
References: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
 <5620784.b19SH5PkdR@phil>
 <ae312dc3-f640-ecf3-049a-c8576bb83330@rock-chips.com>
Message-ID: <3578407.YVa0lydFsh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tao,

Am Sonntag, 12. August 2018, 18:24:45 CEST schrieb Tao Huang:
> On 2018?08?10? 04:09, Heiko Stuebner wrote:
> > Am Mittwoch, 6. Juli 2016, 10:20:54 CEST schrieb Caesar Wang:
> >
> >>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> index a6dd623..12ce265 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> @@ -101,6 +101,18 @@
> >>  			};
> >>  		};
> >>  
> >> +		idle-states {
> >> +			entry-method = "psci";
> >> +			cpu_sleep: cpu-sleep-0 {
> >> +				compatible = "arm,idle-state";
> >> +				local-timer-stop;
> >> +				arm,psci-suspend-param = <0x0010000>;
> >> +				entry-latency-us = <350>;
> >> +				exit-latency-us = <600>;
> >> +				min-residency-us = <1150>;
> > Looking at the chromeos kernel, there are some more patches adapting
> > this idle-state to use different timings.
> Yes, we have another values. So the values of this patch are wrong.
> >
> > There also was a cluster-idle state added for a while but that seems to
> > cause audio issues according to the CrOS history.
> 
> DMA or Audio driver should add PM_QOS_CPU_DMA_LATENCY or other methods to avoid the effects of idle.
> Idle itself is good.

Thanks for the clarification. Do you know if some from Rockchip plans
on submitting a new version of the patch with changed timings and
cluster-sleep?

Otherwise I can also just pull the values from the vendor kernel so that
we get idle states in mainline as well.


Thanks
Heiko
