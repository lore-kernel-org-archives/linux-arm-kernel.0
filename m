From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 26 Jun 2013 16:09:30 +0530
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <20130626081909.GD2718@n2100.arm.linux.org.uk>
References: <51C97F40.5030101@arm.com>
 <20130625184539.GB2718@n2100.arm.linux.org.uk>
 <20130626044842.GR23141@intel.com>
 <20130626081909.GD2718@n2100.arm.linux.org.uk>
Message-ID: <20130626103930.GS23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 09:19:09AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 26, 2013 at 10:18:42AM +0530, Vinod Koul wrote:
> > Yup. This is fixed in slave-dma tree by a patch from mark by renaming it.
> > 
> > This should not show in the -next tree
> 
> Except, that change probably is probably responsible for this new error:
> 
> drivers/dma/amba-pl08x.c: In function 'pl08x_request_mux':
> drivers/dma/amba-pl08x.c:304:13: error: expected identifier before '(' token
This was pushed four days ago and havent seen any error report expect this.

Anyway I rebuild my -next and looks fine for me

  CC      drivers/dma/dmaengine.o
  CC      drivers/dma/virt-dma.o
  CC      drivers/dma/iovlock.o
  CC [M]  drivers/dma/dmatest.o
  CC      drivers/dma/amba-pl08x.o
  LD      drivers/dma/built-in.o

Can you share your config which failed for you?

Mark, I believe you are testing for this, have you seen above error?

--
~Vinod
