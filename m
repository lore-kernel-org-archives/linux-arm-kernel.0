From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Dec 2016 13:27:46 +0000
Subject: [PATCH] arm64: Work around Falkor erratum 1009
In-Reply-To: <20161208114511.GC9768@leverpostej>
References: <20161207200028.4420-1-cov@codeaurora.org>
 <20161207200431.4587-1-cov@codeaurora.org>
 <20161208114511.GC9768@leverpostej>
Message-ID: <20161208132746.GB15141@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 11:45:12AM +0000, Mark Rutland wrote:
> On Wed, Dec 07, 2016 at 03:04:31PM -0500, Christopher Covington wrote:
> > +	asm volatile(ALTERNATIVE(
> > +		     "nop \n"
> > +		     "nop \n",
> > +		     "tlbi vmalle1is \n"
> > +		     "dsb ish \n",
> 
> As a general note, perhaps we want a C compatible NOP_ALTERNATIVE() so
> that the nop case can be implicitly generated for sequences like this.

It's also worth checking what cpus_have_const_cap() would generate for
the default (no workaround required) case.

-- 
Catalin
