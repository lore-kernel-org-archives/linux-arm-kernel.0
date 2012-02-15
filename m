From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 15 Feb 2012 15:19:18 -0500 (EST)
Subject: [PATCH] ARM: ptrace: Include linux/audit.h to fix build errors
In-Reply-To: <1329335879.2337.18.camel@localhost>
References: <1329284188.12708.1.camel@phoenix>
 <20120215083609.GD13673@n2100.arm.linux.org.uk>
 <1329325622.2337.13.camel@localhost>
 <20120215173443.GF27825@n2100.arm.linux.org.uk>
 <1329335879.2337.18.camel@localhost>
Message-ID: <alpine.LFD.2.02.1202151518000.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Feb 2012, Eric Paris wrote:

> On Wed, 2012-02-15 at 17:34 +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 15, 2012 at 12:07:02PM -0500, Eric Paris wrote:
> > > So if someone tells me how the code knows it's endianness I'll gladly
> > > write the ifdef to switch from AUDIT_ARCH_ARMEB to AUDIT_ARCH_ARM when
> > > appropriate....
> > 
> > An easy way would be:
> > 
> > #ifndef __ARMEB__
> > #define AUDIT_ARCH_NR AUDIT_ARCH_ARMEB
> > #else
> > #define AUDIT_ARCH_NR AUDIT_ARCH_ARM
> > #endif
> 
> Is that actually exactly backwards?  ifndef?  (I don't have a clue 
> when __ARMEB__ is set)

__ARMEB__ is set on big endian.  So the above condition should be ifdef 
not ifndef.


Nicolas
