From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Dec 2011 15:10:02 +0000
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <20111212224408.GD4355@morell.nvidia.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <4EE33EC2.6050508@redhat.com> <20111212224408.GD4355@morell.nvidia.com>
Message-ID: <201112131510.02785.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 December 2011, Robert Morell wrote:
> > 
> > Doing a buffer sharing with something that is not GPL is not fun, as, if any
> > issue rises there, it would be impossible to discover if the problem is either
> > at the closed-source driver or at the open source one. At the time I was using
> > the Nvidia proprietary driver, it was very common to have unexplained issues
> > caused likely by bad code there at the buffer management code, causing X
> > applications and extensions (like xv) to break.
> >
> > We should really make this EXPORT_SYMBOL_GPL(), in order to be able to latter
> > debug future share buffer issues, when needed.
> 
> Sorry, I don't buy this argument.  Making these exports GPL-only is not
> likely to cause anybody to open-source their driver, but will rather
> just cause them to use yet more closed-source code that is even less
> debuggable than this would be, to those without access to the source.

But at least the broken module then won't be interacting with other modules
because it cannot share any buffers.

	Arnd
