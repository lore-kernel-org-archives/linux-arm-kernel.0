From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Feb 2013 10:35:03 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <20130226103114.GA16875@arm.com>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226103114.GA16875@arm.com>
Message-ID: <20130226103503.GB16875@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 10:31:14AM +0000, Catalin Marinas wrote:
> On Tue, Feb 26, 2013 at 10:23:26AM +0000, Arnd Bergmann wrote:
> > On Monday 25 February 2013, Stephen Warren wrote:
> > > Is there any other alternative I'm not seeing? Having the kernel
> > > suddenly become incompatible with any currently extant bootloader when I
> > > enable CONFIG_MULTIPLATFORM doesn't seem like a great idea.
> > 
> > Could we make those errata be run-time enabled only when not booting
> > in secure mode?
> 
> There is no easy way to detect whether Linux booted in secure mode,
> unless we add some information in the DT. But I wouldn't add S vs NS
> information, rather which errata need to be enabled by the kernel.

Another difficulty - parsing the DT is done later while some workarounds
are enabled before the MMU (or require the MMU to be disabled
temporarily).

-- 
Catalin
