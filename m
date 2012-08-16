From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Aug 2012 10:43:18 +0100
Subject: Discontiguous memory and cacheflush
In-Reply-To: <20120816091953.GL18957@n2100.arm.linux.org.uk>
References: <20120813160008.GA30302@n2100.arm.linux.org.uk>
 <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
 <20120816082726.GA2101@linaro.org>
 <20120816091953.GL18957@n2100.arm.linux.org.uk>
Message-ID: <20120816094318.GB2101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 10:19:53AM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 16, 2012 at 09:27:26AM +0100, Dave Martin wrote:
> > Could we use the currently must-be-zero flags parameter to add new
> > functionality to this syscall, or are there legacy uses of that
> > parameter (or history of userspace not bothering to zero it?)
> > 
> > For example, we could have something like
> > 
> > do_cache_op(struct iovec *iov, int iovcnt, CF_IOVEC)
> > 
> > to flush a discontiguous set of ranges described by an iovec (though we
> > can of course also describe the ranges in other ways)
> 
> Why overload an existing syscall with multiple different argument types
> rather than having a new syscall with a sane API?

Sure, if it's OK to add a new system call, that would be a cleaner
approach.

Cheers
---Dave
