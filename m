From: jonathan@jonmasters.org (Jon Masters)
Date: Wed, 17 Dec 2014 23:57:05 -0500
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <20141217092505.GA9475@e104818-lin.cambridge.arm.com>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <20141216152707.GH11565@e104818-lin.cambridge.arm.com>
 <5490C83A.2080600@linaro.org>
 <20141217092505.GA9475@e104818-lin.cambridge.arm.com>
Message-ID: <54925EA1.1030901@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/14, 4:25 AM, Catalin Marinas wrote:
> On Wed, Dec 17, 2014 at 12:03:06AM +0000, Al Stone wrote:

>> That being said, the early systems still don't provide PSCI.

Clarification: some early systems are capable of PSCI but the firmware 
was in progress (and thus they implemented the Parking Protocol 
initially but will do full PSCI) - for example AMD Seattle - while one 
other implementation is unable to provide PSCI and will only do Parking 
Protocol. Both are trivially supportable through bits in the ACPI MADT.

>> They will
>> at some point in the future, but not now.  Regardless, I think it's
>> reasonable for us to say that if you want ACPI support, PSCI must be
>> used for secondary CPU startup.  People can hack something up to get
>> the parking protocol to work on development branches if they want, but
>> I personally see no need to get that into the kernel -- and it needs
>> to be said explicitly in arm-acpi.txt.

That could be ok for upstream - it's up to you guys - but note that 
there will be some early hardware that doesn't do PSCI. I've sat on 
*everyone* over the past couple of years behind the scenes to ensure 
that all future designs will do PSCI, but this takes time to realize.

> I'm fine with this. But note that it pretty much rules out the APM
> boards (I think we ruled them out a few times already) which don't have
> an EL3 to host PSCI firmware. EL2 is not suitable as it is likely that
> we want this level for KVM or Xen rather than platform firmware.

The gen1 APM boards work great with UEFI and ACPI using the Parking 
Protocol. It's trivial to support, and it's a fairly constrained since 
everyone is headed toward PSCI. Personally I consider it unfair to 
punish the first guy out of the gate for something that was standardized 
after they made their design. My recommendation would be to get the 
relevant document updated in the public repository. Patches that 
implement Parking Protocol are already in existence/working well as an 
alternative to PSCI (which is always preferred if available).

Jon.
