From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 20 Oct 2016 14:55:45 +0200 (CEST)
Subject: [PATCH] kernel: irq: fix build failure
In-Reply-To: <57FBBA0B.9070500@gmail.com>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
Message-ID: <alpine.DEB.2.20.1610201454410.5073@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Oct 2016, Sudip Mukherjee wrote:

> On Thursday 06 October 2016 11:06 PM, Sudip Mukherjee wrote:
> > The allmodconfig build of powerpc is failing with the error:
> > ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> > 
> > export the symbol to fix the failure.
> 
> Hi Thomas,
> powerpc and arm allmodconfig builds still fails with the same error.
> Build logs of next-20161010 are at:
> arm at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321467
> powerpc at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321473

I know. This is under discussion with the driver folks as we are not going
to blindly export stuff just because someone slapped a irq_set_parent()
into the code w/o knowing why.

Thanks,

	tglx
