From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 15 Jan 2013 09:50:20 -0800
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <20130115165642.GA25500@titan.lakedaemon.net>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <50F3F289.3090402@web.de>
 <20130115165642.GA25500@titan.lakedaemon.net>
Message-ID: <20130115175020.GA3764@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 11:56:42AM -0500, Jason Cooper wrote:
> Greg,
> 
> I've added you to the this thread hoping for a little insight into USB
> drivers and their use of coherent and GFP_ATOMIC.  Am I barking up the
> wrong tree by looking a the drivers?

I don't understand, which drivers are you referring to?  USB host
controller drivers, or the "normal" drivers?  Most USB drivers use
GFP_ATOMIC if they are creating memory during their URB callback path,
as that is interrupt context.  But it shouldn't be all that bad, and the
USB core hasn't changed in a while, so something else must be causing
this.

greg k-h
