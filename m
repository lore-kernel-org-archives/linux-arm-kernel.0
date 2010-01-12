From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 09:53:07 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111235152.GA12051@caradoc.them.org>
References: <20100111235152.GA12051@caradoc.them.org>
Message-ID: <1263289987.29654.17.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 23:51 +0000, Daniel Jacobowitz wrote:
> On Mon, Jan 11, 2010 at 11:31:43PM +0000, Russell King - ARM Linux wrote:
> > It sounds rather evil - maybe the first question that should be asked
> > is whether it is legal to change the PSR flags in the middle of an IT
> > block.
> 
> I'm pretty sure it is.  Catalin, do you know for sure?

16-bit instructions in the IT block other than CMN, CMP and TST do not
set the condition flags. You can use 32-bit instructions for setting the
condition flags inside an IT block.

AFAICT, the ARM ARM doesn't say anything that wouldn't allow changing
the condition flags.

-- 
Catalin
