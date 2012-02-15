From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Feb 2012 17:34:43 +0000
Subject: [PATCH] ARM: ptrace: Include linux/audit.h to fix build errors
In-Reply-To: <1329325622.2337.13.camel@localhost>
References: <1329284188.12708.1.camel@phoenix>
 <20120215083609.GD13673@n2100.arm.linux.org.uk>
 <1329325622.2337.13.camel@localhost>
Message-ID: <20120215173443.GF27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 12:07:02PM -0500, Eric Paris wrote:
> So if someone tells me how the code knows it's endianness I'll gladly
> write the ifdef to switch from AUDIT_ARCH_ARMEB to AUDIT_ARCH_ARM when
> appropriate....

An easy way would be:

#ifndef __ARMEB__
#define AUDIT_ARCH_NR AUDIT_ARCH_ARMEB
#else
#define AUDIT_ARCH_NR AUDIT_ARCH_ARM
#endif

and then:
	audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
