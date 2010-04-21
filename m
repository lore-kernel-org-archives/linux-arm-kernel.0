From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Wed, 21 Apr 2010 11:58:34 +0200
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421095036.GA13971@n2100.arm.linux.org.uk>
References: <4BCE60C4.8020505@codeaurora.org>	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>	<4BCE9E8B.2070103@codeaurora.org>	<20100421072243.GA913@n2100.arm.linux.org.uk>	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
Message-ID: <4BCECC4A.7090504@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 02:39:39AM -0700, skannan at codeaurora.org wrote:
>> Is this an ARM specific decision? Cpufreq certainly supports per cpu scaling
>> and x86 udelay uses per-CPU data. So your concern should apply for x86
>> too. I had the same concern and was planning on bring it up in the cpufreq
>> mailing list after I made sure I didn't misunderstand anything.
> 
> Well, x86 looks buggy in this regard as well - the loops_per_jiffy
> value used is for a CPU which may not run the delay loop.

It looks to me like x86 with a tsc use the tsc for udelay, and handle
cpu changes correctly. See the function delay_tsc in
arch/x86/lib/delay.c. However, they do not seem to handle frequency
changes that well.

-- 
					    Gilles.
