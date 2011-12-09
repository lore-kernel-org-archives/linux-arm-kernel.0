From: rmorell@nvidia.com (Robert Morell)
Date: Fri, 9 Dec 2011 14:50:56 -0800
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <201112051718.48324.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <1322816252-19955-2-git-send-email-sumit.semwal@ti.com>
 <201112051718.48324.arnd@arndb.de>
Message-ID: <20111209225056.GL7969@morell.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 09:18:48AM -0800, Arnd Bergmann wrote:
> On Friday 02 December 2011, Sumit Semwal wrote:
> > This is the first step in defining a dma buffer sharing mechanism.
> 
[...]
> 
> > +	return dmabuf;
> > +}
> > +EXPORT_SYMBOL(dma_buf_export);
> 
> I agree with Konrad, this should definitely be EXPORT_SYMBOL_GPL,
> because it's really a low-level function that I would expect
> to get used by in-kernel subsystems providing the feature to
> users and having back-end drivers, but it's not the kind of thing
> we want out-of-tree drivers to mess with.

Is this really necessary?  If this is intended to be a
lowest-common-denominator between many drivers to allow buffer sharing,
it seems like it needs to be able to be usable by all drivers.

If the interface is not accessible then I fear many drivers will be
forced to continue to roll their own buffer sharing mechanisms (which is
exactly what we're trying to avoid here, needless to say).

- Robert
