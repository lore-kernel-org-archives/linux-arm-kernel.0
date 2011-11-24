From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Nov 2011 13:40:22 -0500 (EST)
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <alpine.LFD.2.02.1111241336320.17904@xanadu.home>
References: <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
 <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
 <20111124125615.GJ8470@opensource.wolfsonmicro.com>
 <20111124160853.GB2509@sirena.org.uk>
 <alpine.LFD.2.02.1111241254310.17904@xanadu.home>
 <20111124180228.GA32119@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111241316510.17904@xanadu.home>
 <20111124183153.GA3395@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111241336320.17904@xanadu.home>
Message-ID: <alpine.LFD.2.02.1111241339480.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Nov 2011, Nicolas Pitre wrote:

> On Thu, 24 Nov 2011, Mark Brown wrote:
> 
> > On Thu, Nov 24, 2011 at 01:22:35PM -0500, Nicolas Pitre wrote:
> > > On Thu, 24 Nov 2011, Mark Brown wrote:
> > 
> > > > Ah, right - I was assuming that the existing code was OK (given that
> > > > it's been in use for years).  What should it be doing to trigger the
> > > > flush?
> > 
> > > Calling s3c_init_cpu(() elsewhere i.e. outside of the s3c64xx_init_io() 
> > > call path, but after the later has been called, would be best.  Maybe 
> > > from mdesc->init_early() ?
> > 
> > It looks like that'll need more substantial refactoring than I have the
> > time to do right now, currently the CPU ID is immediately used to decide
> > how to carry on with low level setup.
> 
> Where, and from what call path?

Nevermind.  I see the problem now.  :-/


Nicolas
