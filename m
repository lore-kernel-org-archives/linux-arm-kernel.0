From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jul 2010 12:03:10 +0100
Subject: [PATCH v3 0/3] Ordered I/O accessors
In-Reply-To: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
References: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100727110310.GA11468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 04:01:12PM +0100, Catalin Marinas wrote:
> This version replaces the do { ... } while (0) constructs in the final
> patch with ({ ... }) to avoid errors in drivers putting brackets around
> the write*() accessors. To avoid the write*() macro having a non-void
> type (and possibly the compiler generating code to read a register), the
> first patch explicitly casts the __raw_write*() accessors to (void).

Ok.  Can you please put this in the patch system?  I think we need to
get this in prior to 2.6.35 being released.
