From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 13:00:48 +0300
Subject: [PATCH] ARM: add warning for invalid kernel page faults
In-Reply-To: <20090928095516.GB6715@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<1254131304-32057-1-git-send-email-imre.deak@nokia.com>
	<20090928095516.GB6715@n2100.arm.linux.org.uk>
Message-ID: <20090928100048.GC30271@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 11:55:16AM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2009 at 12:48:24PM +0300, Imre Deak wrote:
> > To easier detect code that can trigger the above error, add a check
> > also for the case where mmap_sem is acquired. As this has an overhead
> > make it a VM debug warning.
> 
> It _is_ already easy.  I'm not sure why you want even more noise, and
> why you want to break the page fault handling.  From the warning you
> received in your previous post, it said:

The problem is that it happens very rarely. Only if at the time of the
fault the mmap_sem happens to be held. With the change the error would
be apparent at the first fault the offending instruction generates.

For debugging this is very useful, I think.

--Imre
