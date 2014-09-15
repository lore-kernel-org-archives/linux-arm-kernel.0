From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Sep 2014 14:15:06 +0100
Subject: [RFC Resend] arm:extend __init_end to a page align address
In-Reply-To: <20140915105525.GC12361@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB028@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103D6DB4915FB@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103D6DB491607@CNBJMBX05.corpusers.net>
 <20140915105525.GC12361@n2100.arm.linux.org.uk>
Message-ID: <20140915131505.GB5415@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 11:55:25AM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 15, 2014 at 06:26:43PM +0800, Wang, Yalin wrote:
> > this patch change the __init_end address to a page align address, so that free_initmem()
> > can free the whole .init section, because if the end address is not page aligned,
> > it will round down to a page align address, then the tail unligned page will not be freed.
> 
> Please wrap commit messages at or before column 72 - this makes "git log"
> much easier to read once the change has been committed.
> 
> I have no objection to the arch/arm part of this patch.  However, since
> different people deal with arch/arm and arch/arm64, this patch needs to
> be split.

I don't mind how it goes in. If Russell is ok to take the whole patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
