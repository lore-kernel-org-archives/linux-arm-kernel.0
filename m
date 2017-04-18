From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Apr 2017 14:03:26 +0100
Subject: Panic in arch_hw_breakpoint_init() on Cortex-A9 (SPEAr1340)
In-Reply-To: <1492512268.28092.8.camel@v3.sk>
References: <1492512268.28092.8.camel@v3.sk>
Message-ID: <20170418130326.GE17866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 12:44:28PM +0200, Lubomir Rintel wrote:
> Hi,

Hi,

> I'm getting a crash that looks awfully lot like what ddc37832a1 [ARM:
> 8634/1: hw_breakpoint: blacklist Scorpion CPUs] aims to fix.

Just to check, have you successfully booted a kernel on this board
before? i.e. is this a new crash?

> My hardware doesn't use a Scorpion CPU though -- it uses a Cortex-A9
> (cpuid=0x412fc091).
> 
> [????0.157000] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> [????0.157000] Modules linked in:
> [????0.157000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-0.rc3.git0.2.spear2.fc26.armv7hl #1
> [????0.157000] Hardware name: ST SPEAr1340 SoC with Flattened Device Tree
> [????0.157000] task: ef102b80 task.stack: ef0fa000
> [????0.157000] PC is at arch_hw_breakpoint_init+0x130/0x2a0
> [????0.157000] LR is at arch_hw_breakpoint_init+0x7c/0x2a0
> [????0.157000] pc : [<c0e0538c>]????lr : [<c0e052d8>]????psr: 60000013

It would be helpful to know which specific access that is.

Can you figure that out with addr2line, e.g.

 $ addr2line -ife vmlinux c0e0538c

Thanks,
Mark
