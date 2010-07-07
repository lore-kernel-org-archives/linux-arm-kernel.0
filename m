From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Jul 2010 08:49:43 +0100
Subject: About cachetype on ARMv7
In-Reply-To: <013501cb1d6a$47682ea0$d6388be0$%kim@samsung.com>
References: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
	<20100705141719.GA23556@n2100.arm.linux.org.uk>
	<013501cb1d6a$47682ea0$d6388be0$%kim@samsung.com>
Message-ID: <20100707074943.GA21884@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 09:20:57AM +0900, Kukjin Kim wrote:
> > The requirements for N is such the CPU visible conditions which qualify a
> > cache as being VIPT non-aliasing also satisfy PIPT - and a non-aliasing
> > VIPT cache has the same properties as a PIPT cache.
> 
> Thanks for your reply :-)
> 
> You mean PIPT is the same as VIPT non-aliasing.

No, because that's not the case - they are different at the hardware
level.  At the software level, they can be treated the same though.

> Hmm..there is no need to show exactly cachetype in the kernel boot message?

The boot message shows how the kernel drives the cache, not what the
actual cache is - which is far more informative about what the kernel
is doing.

We can find out what the hardware is by looking in specification docs;
we don't need the kernel to tell us that.
