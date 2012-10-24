From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 24 Oct 2012 17:05:11 +0100
Subject: [RFC] Energy/power monitoring within the kernel
In-Reply-To: <5086E6D6.8000208@linaro.org>
References: <1351013449.9070.5.camel@hornet> <5086E6D6.8000208@linaro.org>
Message-ID: <1351094711.23327.47.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-23 at 19:49 +0100, Andy Green wrote:
> A thought on that... from an SoC perspective there are other interesting 
> power rails than go to just the CPU core.  For example DDR power and 
> rails involved with other IP units on the SoC such as 3D graphics unit. 
>   So tying one number to specifically a CPU core does not sound like 
> it's enough.

I do realize this. I just didn't want to try to cover too much ground,
and cpufreq governor would be interested in cpu-related data anyway...

> If you turn the problem upside down to solve the representation question 
> first, maybe there's a way forward defining the "power tree" in terms of 
> regulators, and then adding something in struct regulator that spams 
> readers with timestamped results if the regulator has a power monitoring 
> capability.
> 
> Then you can map the regulators in the power tree to real devices by the 
> names or the supply stuff.  Just a thought.

Hm. Interesting idea indeed - if a regulator device was able to report
the energy being produced by it (instead of looking at cumulative energy
consumed by more than one device), defining "power domains" (by adding
selected cpus as consumers) would be straight forward and the cpufreq
could request the information that way.

I'll look into it, thanks!

Pawe?
