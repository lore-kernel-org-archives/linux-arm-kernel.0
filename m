From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Feb 2012 09:52:16 +0000
Subject: [PATCH] ARM: ptrace: Include linux/audit.h to fix build errors
In-Reply-To: <20120215083609.GD13673@n2100.arm.linux.org.uk>
References: <1329284188.12708.1.camel@phoenix>
 <20120215083609.GD13673@n2100.arm.linux.org.uk>
Message-ID: <20120215095216.GA29319@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 08:36:09AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 15, 2012 at 01:36:28PM +0800, Axel Lin wrote:
> > Include linux/audit.h to fix below build errors:
> > 
> >   CC      arch/arm/kernel/ptrace.o
> > arch/arm/kernel/ptrace.c: In function 'syscall_trace':
> > arch/arm/kernel/ptrace.c:919: error: implicit declaration of function 'audit_syscall_exit'
> > arch/arm/kernel/ptrace.c:921: error: implicit declaration of function 'audit_syscall_entry'
> > arch/arm/kernel/ptrace.c:921: error: 'AUDIT_ARCH_ARMEB' undeclared (first use in this function)
> 
> Err, can someone explain why we seem to tell the audit code that we're
> always big endian?

I can't see this patch in the linux-arm-kernel archives, so that's probably
why we missed it. The fix should be pretty straightforward though - Axel,
care to add the appropriate ifdeffery?

Will
