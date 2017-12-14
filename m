From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 14 Dec 2017 09:07:54 +0800
Subject: [PATCH] arm64: dts: hisilicon: Add hi3660 cpu capacity-dmips-mhz
 information
In-Reply-To: <cddaf386-5688-a064-7cb0-1e75485330c4@arm.com>
References: <1513174866-6678-1-git-send-email-valentin.schneider@arm.com>
 <20171213145311.GA30463@leoy-ThinkPad-T440>
 <cddaf386-5688-a064-7cb0-1e75485330c4@arm.com>
Message-ID: <20171214010754.GC30419@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 03:16:13PM +0000, Valentin Schneider wrote:
> Hi Leo,
> 
> 
> On 12/13/2017 02:53 PM, Leo Yan wrote:
> >Hi Valentin,
> >
> >On Wed, Dec 13, 2017 at 02:21:06PM +0000, Valentin Schneider wrote:
> >>The following dt entries are added:
> >>  cpus [0-3] (Cortex A53):
> >>    - capacity-dmips-mhz = <592>;
> >>
> >>  cpus [4-7] (Cortex A73):
> >>    - capacity-dmips-mhz = <1024>;
> >>
> >>Those values were obtained by running dhrystone 2.1 on a
> >>HiKey960 with the following procedure:
> >>- Offline all CPUs but CPU0 (A53)
> >>- Set CPU0 frequency to maximum
> >>- Run Dhrystone 2.1 for 20 seconds
> >>
> >>- Offline all CPUs but CPU4 (A73)
> >>- set CPU4 frequency to maximum
> >>- Run Dhrystone 2.1 for 20 seconds
> >>
> >>The results are as follows:
> >>A53: 129633887 loops
> >>A73: 287034147 loops
> >Seems to me the capacity-dmips-mhz should be:
> >
> >CA53: 129633887 / 20 / 1844 = 3515
> >CA73: 287034147 / 20 / 2362 = 6076
> >
> >After normalized to range [0..1024], we could get:
> >
> >CA53:  592
> >CA73: 1024
> 
> Yes, that's the "direct approach". I wanted to underline the fact that there
> are two different max frequencies so what I followed would be:
> 
> 1) Computing the performance ratio:
> (129633887 / 287034147) * 1024 = 462.47
> 
> 2) Scaling that to the same frequency scale:
> 462.47 * (2362/1844) = 592.38
> 
> Which gives the same end result (it's the same equation but split in two
> steps). Also it makes it easy to check that the cpu_capacity sysfs entry for
> the A53s gets correctly set (to 462).

Yeah, thanks for clear explanation.

[...]

Thanks,
Leo Yan
