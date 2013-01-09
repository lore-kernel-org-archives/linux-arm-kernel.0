From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jan 2013 16:37:18 -0500 (EST)
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <201301092115.20327.arnd@arndb.de>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <201301092022.49130.arnd@arndb.de>
 <alpine.LFD.2.02.1301091554250.6300@xanadu.home>
 <201301092115.20327.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1301091627010.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Arnd Bergmann wrote:

> On Wednesday 09 January 2013, Nicolas Pitre wrote:
> > > If we decide that building an allnoconfig without any platform
> > > is actually ok, we could just as well rip out that error statement.
> > 
> > Is it expected for allnoconfig kernels to still boot on other 
> > architectures? If so I think we should try to still provide a valid 
> > config even in the allnoconfig case.
> 
> The practical use of a kernel without any device drivers or file
> systems is pretty low, I would not expect such a kernel to be
> any useful.

I didn't say "useful".  But at least "booting" e.g. to print out a 
kernel oops because no root filesystem is available or the like should 
be a minimum.  Having the wrong platform configured in might prevent 
even that from working, but at least we shouldn't allow for a kernel 
config that we know in advance has no chance of ever executing anywhere.


Nicolas
