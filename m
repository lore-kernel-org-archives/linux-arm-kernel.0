From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Aug 2012 19:14:17 +0000
Subject: [PATCH 01/11] ARM: topology: mark init_cpu_topology as __init
In-Reply-To: <5022A79E.6050504@codeaurora.org>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-2-git-send-email-arnd@arndb.de>
 <5022A79E.6050504@codeaurora.org>
Message-ID: <201208081914.17651.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 August 2012, Stephen Boyd wrote:
> 
> On 08/08/12 07:47, Arnd Bergmann wrote:
> > The init_cpu_topology function can be put into the __init section
> > and discarded after boot, because it is only called from
> > smp_prepare_cpus, which is also marked __init. This was reported
> > by gcc after Vincent Guittot added the parse_dt_topology function
> > in 339ca09d7ada "ARM: 7463/1: topology: Update cpu_power according to DT
> > information".
> >
> > Without this patch, building kzm9g_defconfig results in:
> >
> > WARNING: vmlinux.o(.text+0xb5a0): Section mismatch in reference from the function init_cpu_topology() to the function .init.text:parse_dt_topology()
> > The function init_cpu_topology() references
> > the function __init parse_dt_topology().
> > This is often because init_cpu_topology lacks a __init
> > annotation or the annotation of parse_dt_topology is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> 
> This is already in the patch tracker
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7482/1

Ok, dropped here.

> I also notice that store_cpu_topology() should be marked __cpuinit and
> update_siblings_mask, middle_capacity, cpu_capacity, and
> update_cpu_power should be static. We should probably also rename
> update_cpu_power() so as to not conflict with the one in kernel/sched/fair.c

Yes, all good points. 

	Arnd
