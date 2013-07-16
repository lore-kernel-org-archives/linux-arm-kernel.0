From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 16 Jul 2013 13:19:17 +0300
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <51E439BC.9030608@wwwdotorg.org>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
Message-ID: <20130716101917.GZ21962@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 08:04:44PM +0200, Stephen Warren wrote:
> On 06/25/2013 03:23 AM, Joseph Lo wrote:
> > Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> > to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> > this state.
> 
> I tried applying this patch, your series "[PATCH V3 0/3] ARM: tegra114:
> cpuidle: add power down state", and your series "[PATCH V2 00/11] ARM:
> tegra114: add support for system suspend", all on top of v3.11-rc1.
> 
> On Dalmore, the new cpuidle mode /appears/ to work (I see increasing
> values in the sysfs cpuidle "usage" file for all defined cpuidle
> states), but I don't see the "CPU VDD off" LED light up; I'm not
> convinced that the CPU is actually being powered off in the idle mode.

The current patchset only powergates the individual cores on Tegra114. The
entire cluster (including L2 cache etc) isn't railgated as a CPUidle state.
Hence the CPU VDD off LED will never be on.

Cheers,

Peter.
