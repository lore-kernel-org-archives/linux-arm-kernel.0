From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 May 2013 12:16:42 +0100
Subject: [PATCH] arm: mm: Use phys_addr_t properly for ioremap functions
In-Reply-To: <20130502180237.GY14496@n2100.arm.linux.org.uk>
References: <1366761098-4485-1-git-send-email-lauraa@codeaurora.org>
 <20130502180237.GY14496@n2100.arm.linux.org.uk>
Message-ID: <20130514111642.GH18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 07:02:37PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 23, 2013 at 04:51:38PM -0700, Laura Abbott wrote:
> > -	unsigned long last_addr;
> > - 	unsigned long offset = phys_addr & ~PAGE_MASK;
> > +	phys_addr_t last_addr;
> > +	phys_addr_t offset = phys_addr & ~PAGE_MASK;
> 
> BTW, this doesn't need to be phys_addr_t.  An offset of a page is always
> less than 32-bits.

As I said to Arnd on the 2nd May, I've dropped this patch because it was
causing too many other problems.  I'd much prefer to have a single patch
which made this change and fixed all the other places which Arnd identified
as well.  If you still want to make this change, please ensure that all
implementations and users of ioremap() are correctly updated in a single
patch and resubmit.  Thanks.
