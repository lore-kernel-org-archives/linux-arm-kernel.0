From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 21 Sep 2012 08:23:53 +1000
Subject: [PATCH 0/4] Fix PROT_NONE page permissions when !CPU_USE_DOMAINS
In-Reply-To: <20120920221215.GA1837@n2100.arm.linux.org.uk>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <20120920221215.GA1837@n2100.arm.linux.org.uk>
Message-ID: <1348179833.1132.36.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 23:12 +0100, Russell King - ARM Linux wrote:

 .../...

> That'll make the set_pte assembly more horrid, but I guess that's the
> price you pay for removing useful features which architecture folk don't
> like from CPUs... and it gets more horrid because you can't encode some
> of those bit patterns with the standard 8-bit and shift opcode
> representation.
> 
> Really fun bug, but it needs more thought about how to solve it.

Yeah, fun isn't it ? :-)

The x86 way to solve it is simple, though ugly ... They use a SW bit
called "PROTNONE". A PROT_NONE page gets that instead of the HW valid
bit and pte_present() test if any of them is set.

Cheers,
Ben.
