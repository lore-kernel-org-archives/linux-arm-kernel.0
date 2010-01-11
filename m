From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Jan 2010 16:26:30 +0000
Subject: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do
	notinvalidate clean lines
In-Reply-To: <20100111152333.GB4109@n2100.arm.linux.org.uk>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
	<1263220628.6305.44.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
	<20100111152333.GB4109@n2100.arm.linux.org.uk>
Message-ID: <1263227190.6305.51.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 15:23 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> > > Do you need to specify "r12" as well? What about "cc", are they
> > > preserved by the secure monitor?
> >
> > r12 and reset of the registers are preserved. Lr needs to be saved but
> > because of function call, the compiler saves/restores it.
> 
> That's not guaranteed; the compiler can re-use lr for its own purposes
> within a function.  You need to add lr to the list of clobbered registers.

Do we need to specify "r12" in the list of clobbered registers as the
inline asm explicitly modifies it? Or the compiler doesn't touch it.

-- 
Catalin
