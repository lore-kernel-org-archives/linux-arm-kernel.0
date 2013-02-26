From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Feb 2013 10:31:14 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <201302261023.26939.arnd@arndb.de>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
Message-ID: <20130226103114.GA16875@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 10:23:26AM +0000, Arnd Bergmann wrote:
> On Monday 25 February 2013, Stephen Warren wrote:
> > Is there any other alternative I'm not seeing? Having the kernel
> > suddenly become incompatible with any currently extant bootloader when I
> > enable CONFIG_MULTIPLATFORM doesn't seem like a great idea.
> 
> Could we make those errata be run-time enabled only when not booting
> in secure mode?

There is no easy way to detect whether Linux booted in secure mode,
unless we add some information in the DT. But I wouldn't add S vs NS
information, rather which errata need to be enabled by the kernel.

-- 
Catalin
