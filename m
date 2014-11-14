From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Nov 2014 10:42:46 +0000
Subject: some question about TCR setting
In-Reply-To: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
Message-ID: <20141114104246.GA25828@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 07:22:01AM +0000, vichy wrote:
> hi all:
> from armv8 spec, no matter TCR_EL1/2/3, there are
> 1. SH (shareability)
> 2. ORGN (outer cacheability)
> 3. IRGN(inner cacheability)
> 
> but in the each level block/page descriptor, there are also
> sharability, inner, outter, cacheability as well.
> 
> What is the difference between the sharability, inner/outer
> cacheability between TCR and Block/page descriptors?

The {SH,ORGN,IRGN}{1,0} fields in the TCR define which attributes the
CPU will use when walking page tables, while the attributes in the
tables themselves apply to other memory accesses.

> Why are there attributes setting keep in TCR?

The CPU needs to know the attributes to read the page tables with.

The CPU can't read the attributes from the page tables, because in order
to do so it would need to know the attributes to access the page tables
with. Additionally, the page tables might not always be mapped into the
virtual address space.

Mark.
