From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 10:46:21 +0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <AANLkTinMobeQBz_ruGAeOSoTWP_9-0Aw4-=8Sk3JxEjX@mail.gmail.com>
References: <AANLkTinMobeQBz_ruGAeOSoTWP_9-0Aw4-=8Sk3JxEjX@mail.gmail.com>
Message-ID: <20110103104621.GF26785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 09:16:15AM +0100, Vincent Guittot wrote:
> I'm also interested in hotplug latency measurement and have done some
> on my CA9 platform u8500. I have the same kind of result for plugging
> a secondary cpu:
>   total duration = 295ms
>   166 us for the low level cpu wake up
>   228ms between the return from platform_cpu_die and the cpu becomes online
> 
> I have added some trace events for doing these measurements and I'd
> like to add some generic traces point in the cpu hotplug code like we
> already have in power management code (cpuidle, suspend, cpufreq ...)
> These traces could be used with power events for studying the impact
> of cpu hotplug in the complete power management scheme.

Note that if you pass lpj=<number> to the kernel, you'll bypass the
calibration and have a faster response to CPU onlining.
