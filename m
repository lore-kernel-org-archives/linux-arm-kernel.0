From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Jul 2013 14:15:20 +0100
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130713T225129-903@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey>
 <loom.20130713T225129-903@post.gmane.org>
Message-ID: <20130715131520.GA16220@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 13, 2013 at 10:13:12PM +0100, Harm Hanemaaijer wrote:
> Dr. David Alan Gilbert <gilbertd <at> treblig.org> writes:
> 
> > 
> > You might like to compare with some of the routines at:
> > https://launchpad.net/cortex-strings
> > and some of the numbers at:
> > https://wiki.linaro.org/WorkingGroups/ToolChain/Benchmarks/
> 
> That's interesting. I had looked at cortex-strings before but didn't
> dig into it, also because its benchmark program seemed to be limited in
> scope. From the Linaro numbers it seems NEON isn't always a win
> especially on newer Cortex platforms, with large variability across
> different platforms/cores.

As it has been stated in this thread, we shouldn't use Neon for memcpy.
There is a significant overhead with saving/restoring Neon registers,
preemptability.

But Cortex Strings is a good starting point and Linaro is going to port
some of these functions to the Linux kernel for ARMv8 (AArch64).

-- 
Catalin
