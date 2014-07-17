From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 17 Jul 2014 11:32:45 +0200
Subject: ARM: mvebu: ARCH_HAS_CPUFREQ
In-Reply-To: <1405588702.4808.6.camel@x220>
References: <1405588702.4808.6.camel@x220>
Message-ID: <20140717113245.121277bb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Paul Bolle,

On Thu, 17 Jul 2014 11:18:22 +0200, Paul Bolle wrote:

> 0) Linux-next includes your commit a02829b0485e ("ARM: mvebu: allow
> enabling of cpufreq on Armada XP") as of today (next-20140717).
> 
> 1) That commit only adds
>     select ARCH_HAS_CPUFREQ
> 
> to a Kconfig entry. But ARCH_HAS_CPUFREQ was dropped in v3.16-rc2, see
> commit 19682f72f5db ("ARM: Remove ARCH_HAS_CPUFREQ config option").
> While I don't know what you want to achieve here, selecting
> ARCH_HAS_CPUFREQ certainly won't help you.

Thanks for the notification. The issue is that the cpufreq branch I've
sent to Jason is based on 3.16-rc1, which does not have 19682f72f5db.

Jason, I believe you could simply drop the patch a02829b0485e, since
all it does is selecting this ARCH_HAS_CPUFREQ option which no longer
exists.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
