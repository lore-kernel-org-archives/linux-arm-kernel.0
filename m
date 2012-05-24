From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 May 2012 13:12:12 +0000
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <op.wes3e3w72s3iss@ecaz>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231939.49681.arnd@arndb.de> <op.wes3e3w72s3iss@ecaz>
Message-ID: <201205241312.13194.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 May 2012, Imre Kaloz wrote:
> The gpiolib patch originated from me as well.

I've changed the author tag in the changeset to you now, and
noted the fact that Richard submitted it.

> > What is the plan for ixp4xx going forward? Is one of you planning to
> > maintain a git tree and collect patches for inclusion in arm-soc?
> > I would be more comfortable just knowing where to pull from than
> > having to watch the mailing list and making sure the maintainers
> > Ack all the patches.
> >
> > If there is no tree, should we downgrade ixp4xx in the MAINTAINERS
> > file from "Maintained" to "Odd fixes"?
> 
> Quite some patches are still in the OpenWrt repo only. When I'll have  
> time, I'll revisit those as well as migrate ixp4xx to DT. I'm overloaded  
> with work, so I'll need a few more weeks and I guess the same is true for  
> Krzysztof as well..

Ok, good to hear that you're still interested! I don't get the impression
that migrating ixp4xx to DT is urgent in any way, but I also don't think
it will be too much work. If all you want to do is allow the board files
to be replaced with DT, then I assume you need bindings for the flash,
ethernet and CF devices and convert the interrupt controller to use
irq domains. For PCI, it should be enough to provide a generic map_irq
function that uses the standard interrupt-maps property. That function
can even be defined in a way that is usable independent of the platform.

	Arnd
