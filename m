From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Oct 2016 12:00:20 +1100
Subject: [PATCH] kernel: irq: fix build failure
In-Reply-To: <alpine.DEB.2.20.1610201454410.5073@nanos>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
 <alpine.DEB.2.20.1610201454410.5073@nanos>
Message-ID: <20161021120020.52b3fa35@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, 20 Oct 2016 14:55:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 10 Oct 2016, Sudip Mukherjee wrote:
> 
> > On Thursday 06 October 2016 11:06 PM, Sudip Mukherjee wrote:  
> > > The allmodconfig build of powerpc is failing with the error:
> > > ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> > > 
> > > export the symbol to fix the failure.  
> > 
> > Hi Thomas,
> > powerpc and arm allmodconfig builds still fails with the same error.
> > Build logs of next-20161010 are at:
> > arm at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321467
> > powerpc at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321473  
> 
> I know. This is under discussion with the driver folks as we are not going
> to blindly export stuff just because someone slapped a irq_set_parent()
> into the code w/o knowing why.

Do we have any idea if a resolution is close.  This was first reported
in linux-next in September 14/15.  :-(

-- 
Cheers,
Stephen Rothwell
