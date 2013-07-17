From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 17 Jul 2013 14:19:14 +0800
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <51E53858.6090207@linaro.org>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
 <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
 <51E53858.6090207@linaro.org>
Message-ID: <1374041954.10997.1.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-16 at 20:11 +0800, Daniel Lezcano wrote:
> On 07/16/2013 01:17 PM, Joseph Lo wrote:
> > On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
> >> On 06/25/2013 03:23 AM, Joseph Lo wrote:
> >>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> >>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> >>> this state.
> >>
> >> I tried applying this patch, your series "[PATCH V3 0/3] ARM: tegra114:
> >> cpuidle: add power down state", and your series "[PATCH V2 00/11] ARM:
> >> tegra114: add support for system suspend", all on top of v3.11-rc1.
> >>
> >> On Dalmore, the new cpuidle mode /appears/ to work (I see increasing
> >> values in the sysfs cpuidle "usage" file for all defined cpuidle
> >> states), but I don't see the "CPU VDD off" LED light up; I'm not
> >> convinced that the CPU is actually being powered off in the idle mode.
> >>
> > The LED of the CPU Vdd indicates the power of CPU cluster. But the
> > series of CPU idle power down mode support for Tegra114 only supports
> > per core power down. It did not support cluster power down yet in idle
> > mode. That needs some extra work to support cluster power down in idle
> > mode.
> > There are some items that I plat to do:
> > 1. integrate the MCPM (multi cluster power management) code into Tegra
> > CPU PM code
> 
> +1
> 
> > 2. integrate coupled CPUidle framework into Tegra CPU idle driver
> 
> If you are using the MCPM, I suggest you rely on the MCPM to replace the
> coupled idle state by it. The code will look much more consistent.
> 
Yes, true. Thanks for your advise.

Joseph
