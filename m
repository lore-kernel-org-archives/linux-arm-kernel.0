From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 21 Aug 2009 16:50:11 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1250869355.10642.10.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
Message-ID: <20090821155011.GB8583@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Fri, 2009-08-21 at 16:07 +0100, Richard Crewe wrote:
> > Section A2.9.3 of the ARM architecture ref. manual seems to imply that 
> > ldrex/strex instruction pairs won't work correctly if they are nested 
> > due to pre-emption.
> > 
> > Should a strex instruction be added to the low-level interrupt handler 
> > or should all ldrex/strex instruction pairs be protected from 
> > pre-emption by disabling interrupts?
> 
> There is no need to since preemption means rescheduling which implies a
> call to the __switch_to function in entry-armv.S. This function clears
> the exclusive monitor state explicitly.

What about when an interrupt handler uses ldrex/strex?  There is no
call to __switch_to.

-- Jamie
