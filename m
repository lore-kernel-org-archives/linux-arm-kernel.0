From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Oct 2012 11:36:37 +0100
Subject: bug with 3.4.6, 3.5.3, 3.6.1
In-Reply-To: <50765D3B.6000909@xenomai.org>
References: <50765D3B.6000909@xenomai.org>
Message-ID: <20121011103637.GC30598@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 06:46:35AM +0100, Gilles Chanteperdrix wrote:
> Hi,

Hi Gilles,

> when booting Linux v3.4.6, v3.5.3, or v3.6.1 on a pandaboard with an 
> OMAP4430 ES2.1, compiled with the following configuration:
> http://xenomai.org/~gch/config-panda
> 
> I get the bug below after mounting the root filesystem.
> 
> CONFIG_VMSPLIT_2G and CONFIG_THUMB2_KERNEL disabled seems to be the 
> combination which triggers the bug.
> 
> With this configuration, it seems the init_mm.mm_count incrementation
> done at the beginning of secondary_start_kernel() is "lost" after the
> calls to cpu_switch_mm() and local_flush_tlb().
> 
> Modifying the secondary_startup() function in head.S to pass the 
> swapper pgdir instead of the idmap pgdir in r4 also avoids the issue.

What's your PHYS_OFFSET? I suspect it's >= 2GB, in which case I have some
ideas about this problem.

Will
