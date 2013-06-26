From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Jun 2013 13:00:31 +0100
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <20130626103930.GS23141@intel.com>
References: <51C97F40.5030101@arm.com>
 <20130625184539.GB2718@n2100.arm.linux.org.uk>
 <20130626044842.GR23141@intel.com>
 <20130626081909.GD2718@n2100.arm.linux.org.uk>
 <20130626103930.GS23141@intel.com>
Message-ID: <20130626120031.GN27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 04:09:30PM +0530, Vinod Koul wrote:
> On Wed, Jun 26, 2013 at 09:19:09AM +0100, Russell King - ARM Linux wrote:

> > Except, that change probably is probably responsible for this new error:

> > drivers/dma/amba-pl08x.c: In function 'pl08x_request_mux':
> > drivers/dma/amba-pl08x.c:304:13: error: expected identifier before '(' token

> This was pushed four days ago and havent seen any error report expect this.

> Anyway I rebuild my -next and looks fine for me

>   CC      drivers/dma/dmaengine.o
>   CC      drivers/dma/virt-dma.o
>   CC      drivers/dma/iovlock.o
>   CC [M]  drivers/dma/dmatest.o
>   CC      drivers/dma/amba-pl08x.o
>   LD      drivers/dma/built-in.o

> Can you share your config which failed for you?

> Mark, I believe you are testing for this, have you seen above error?

No, that looks like the original error that was being fixed.  The driver
build tested OK for me at the time and currently in -next, though a tree
which has the additional include but not the rename away from get_signal
will obviously still have the issue.

BTW for build coverage it'd be handy if AMBA could be enabled without
having to be explicitly selected.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/1ef851cb/attachment.sig>
