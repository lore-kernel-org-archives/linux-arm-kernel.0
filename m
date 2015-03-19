From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Mar 2015 19:39:27 +0000
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150319101727.GC24556@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com>
 <20150319101727.GC24556@red-moon>
Message-ID: <20150319193927.GG4751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 10:17:27AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
> > On 2015/3/19 3:05, Will Deacon wrote:
> > > On Wed, Mar 11, 2015 at 12:39:26PM +0000, Hanjun Guo wrote:
> > >> This patch set already tested on multi platforms:
> > >>  - AMD Seattle board;
> > >>  - Cavium Thunder board;
> > >>  - Huawei D02 board;
> > >>  - Qualcomm ARM64 platform
> > >>
> > >> This version 10 patch set address some minor comments and collect ACKs and
> > >> Reviewed-bys for v9:
> > >>
> > >>  - new Acks from Rafael, Olof, Grant, Lorenzo
> > >>  - new way to handle typdef phys_cpuid_t which suggested by Rafael,
> > >>    but no functional change
> > >>  - Remove if(!phys) for early ioremappings
> > >>  - Rework sleep function for ARM64
> > >>  - Introduce linux/acpi_irq.h to hold acpi_irq_init()
> > >>  - Disable ACPI if not HW_REDUCED_ACPI compliant
> > >>  - Remove the doc of why ACPI on ARM
> > > So I've had a look at the current state of this series and I think there
> > > are a few immediate things left to do:
> > >
> > >   (1) Resolve the acpi=force cmdline issue highlighted by Lorenzo and
> > >       Catalin
> > 
> > Sure, it will be done after the confirmation with Ard.
> > 
> > >
> > >   (2) I believe Sudeep and Lorenzo have concerns about patch 13 (SMP init),
> > >       so I'm assuming there will be additional patches from them that are
> > >       required.
> > 
> > Sorry, I assume that it is about the print information for PSCI absent for SMP init, right?
> 
> Not only that, Sudeep has a patch to consolidate DT and ACPI SMP code,
> I am working on it, I do not think it should be a blocking point, patch
> coming asap on top of your series.

Well, I don't really want to merge the series without those patches so I
do think it blocks the code from getting into mainline.

Will
