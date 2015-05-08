From: Dave.Martin@arm.com (Dave P Martin)
Date: Fri, 8 May 2015 09:50:29 +0100
Subject: [PATCH] Revert "serial/amba-pl011: Leave the TX IRQ alone when
 the UART is not open"
In-Reply-To: <20150507232835.GD5449@kroah.com>
References: <20150507105934.GA18402@e103592.cambridge.arm.com>
 <20150507232835.GD5449@kroah.com>
Message-ID: <20150508085029.GA17900@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 12:28:35AM +0100, Greg Kroah-Hartman wrote:
> On Thu, May 07, 2015 at 11:59:47AM +0100, Dave Martin wrote:
> > Calling serial maintainers...
> > 
> > Please consider the following commit for merging in v4.1.
> > 
> > f28c1d0a78a8c6a217ac5362cb719efa169ae2a7 Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is not open"
> > 
> > This backs out a misguided optimisation that is causing pl011 driver
> > deadlocks for some people in certain scenarios (my bad).
> > 
> > The revert is self-contained and independent of the other changes I
> > posted.
> > 
> > Thanks
> > ---Dave
> > 
> > 
> > Original commit message:
> > 
> > This reverts commit f2ee6dfa0e8597eea8b98d240b0033994e20d215.
> 
> Please send this in a format I can apply it in...

The revert has been posted twice on this list and you already applied it
to tty-next with commit ID f28c1d0a78a8c6a217ac5362cb719efa169ae2a7
(thanks btw).  I could have made that clearer...

I'm happy to post it again, but I assumed (wrongly?) that you'd prefer
to cherry-pick it from your own branch.  If you really want me to
post a duplicate, please confirm.

I was concerned that posting a duplicate of a patch you already
picked up would risk further confusion...

Cheers
---Dave
