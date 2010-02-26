From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 26 Feb 2010 11:52:07 -0500 (EST)
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
Message-ID: <Pine.LNX.4.44L0.1002261150370.2029-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Feb 2010, Catalin Marinas wrote:

> For mmap'ed pages (and present in the page cache), is it guaranteed that
> the HCD driver won't write to it once it has been mapped into user
> space? If that's the case, it may solve the problem by just reversing
> the meaning of PG_arch_1 on ARM and assume that a newly allocated page
> has dirty D-cache by default.

Nothing is guaranteed.  The HCD will write to wherever it is asked.  If 
a driver does input to an mmap'ed page, the HCD won't even know that 
the page is mmap'ed.

Alan Stern
