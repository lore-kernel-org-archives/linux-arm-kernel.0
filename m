From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Mar 2013 02:23:08 +0000
Subject: ARM: 7653/2: do not scale loops_per_jiffy when using a constant
 delay clock
Message-ID: <20130306022308.GA21539@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

I notice that commit 70264367a243 ("ARM: 7653/2: do not scale loops_per_jiffy
when using a constant delay clock") is in mainline, but I'm not sure whether
it's the right fix. Unfortunately, I failed to find it in the list archives,
so I couldn't repy to the original patch.

It seems like a better fix would be to pass the CPUFREQ_CONST_LOOPS flag from
the cpufreq driver doing the frequency scaling, which would prevent
loops_per_jiffy from being scaled at all. It also means that UP platforms
would work correctly, while I think they're still broken with your patch.

What do you reckon? I'm trying to do some cleanup in this area with the aim
of making the core cpufreq driver SMP-aware.

Cheers,

Will
