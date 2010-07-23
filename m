From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 23 Jul 2010 10:50:47 +0530
Subject: hotplug and init section
In-Reply-To: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
References: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6254E4A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of smuckle at codeaurora.org
> Sent: Friday, July 23, 2010 1:03 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Subject: hotplug and init section
> 
> Hi,
> 
> I'm working on hotplug support. It looks like currently only mach-realview
> supports this on ARM, and it does not fully power down the core.  The core
> just goes into wfi. If we fully power down the core being hot-removed, we
> need to rerun the processor init, enable mmu, turn on mmu, etc when it is
> brought back up.
> 
> This code is currently all put in the .init section. Changing things so
> that the code required for bringing up secondary cores is still present
> after init looks to be a fairly big change. As such I wanted to see if
> anyone had thoughts here before I start hacking up head.S, the linker
> script, etc.
> 
Not sure whether you need to really start from scratch for hotplugged CPU. If you have proper context save /restore, you can avoid full restart of the CPU.

Regards,
Santosh
