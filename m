From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Jul 2010 22:09:16 +0100
Subject: [PATCH v3 0/3] Ordered I/O accessors
In-Reply-To: <20100727110310.GA11468@n2100.arm.linux.org.uk>
References: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
	<20100727110310.GA11468@n2100.arm.linux.org.uk>
Message-ID: <1280351356.16413.1.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-27 at 12:03 +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 14, 2010 at 04:01:12PM +0100, Catalin Marinas wrote:
> > This version replaces the do { ... } while (0) constructs in the final
> > patch with ({ ... }) to avoid errors in drivers putting brackets around
> > the write*() accessors. To avoid the write*() macro having a non-void
> > type (and possibly the compiler generating code to read a register), the
> > first patch explicitly casts the __raw_write*() accessors to (void).
> 
> Ok.  Can you please put this in the patch system?  I think we need to
> get this in prior to 2.6.35 being released.

I pushed the three patches to the patch system (I'm still around
tomorrow and then off-line for a week, so please let me know if there
are any issues).

Thanks.

-- 
Catalin
