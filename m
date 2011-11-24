From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Nov 2011 13:22:35 -0500 (EST)
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111124180228.GA32119@opensource.wolfsonmicro.com>
References: <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
 <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
 <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
 <20111124125615.GJ8470@opensource.wolfsonmicro.com>
 <20111124160853.GB2509@sirena.org.uk>
 <alpine.LFD.2.02.1111241254310.17904@xanadu.home>
 <20111124180228.GA32119@opensource.wolfsonmicro.com>
Message-ID: <alpine.LFD.2.02.1111241316510.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Nov 2011, Mark Brown wrote:

> On Thu, Nov 24, 2011 at 12:59:38PM -0500, Nicolas Pitre wrote:
> 
> > No.  The s3c64xx code is wrong.  It relies on a freshly installed 
> > mapping that has not been flushed to RAM yet.  So when it works for you, 
> > That's due to pure luck, most probably because the page table is not 
> > cached when the mapping is created and the cache is not allocated on 
> > write.
> 
> Ah, right - I was assuming that the existing code was OK (given that
> it's been in use for years).  What should it be doing to trigger the
> flush?

Calling s3c_init_cpu(() elsewhere i.e. outside of the s3c64xx_init_io() 
call path, but after the later has been called, would be best.  Maybe 
from mdesc->init_early() ?


Nicolas
