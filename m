From: geoff@infradead.org (Geoff Levand)
Date: Wed, 24 Sep 2014 17:24:42 -0700
Subject: [PATCH 08/13] arm64: Use cpu_ops for smp_stop
In-Reply-To: <20140915190616.GC14191@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <36ad9302497338a34cc7174a72a2ac99ceb16fdb.1410302383.git.geoff@infradead.org>
 <20140915190616.GC14191@leverpostej>
Message-ID: <1411604682.6001.178.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, 2014-09-15 at 20:06 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> On Tue, Sep 09, 2014 at 11:49:05PM +0100, Geoff Levand wrote:
> > The current implementation of ipi_cpu_stop() is just a tight infinite loop
> > around cpu_relax().  This infinite loop implementation is OK if the machine
> > will soon do a poweroff, but it doesn't have any mechanism to allow a CPU
> > to be brought back on-line, nor is it compatible with kexec re-boot.
> 
> I don't see why we should use this when we have disable_nonboot_cpus.

I decided to use disable_nonboot_cpus, so this patch is no longer
needed.  I'll put the rework of disable_nonboot_cpus to not depend on
CONFIG_PM_SLEEP_SMP on my todo list.

-Geoff
