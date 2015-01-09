From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Jan 2015 11:55:51 +0100
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1610983.9vqJdsL27R@wuerfel>
 <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
Message-ID: <3341506.a2BFqPNg3k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 January 2015 10:33:07 Catalin Marinas wrote:
> On Wed, Jan 07, 2015 at 07:48:48PM +0000, Arnd Bergmann wrote:

> > In other cases that's actually a good thing. One such example is the
> > "Principles of ARM Memory Maps" document that tells hardware implementers
> > to do a rather complex mapping "To support 36-bit x86 PAE compatible operating
> > systems, such as Linux." but makes life much harder in the process than
> > any of the random mappings we have seen in the wild.
> 
> Unfortunately, with any significant amount of RAM (say 16GB), this
> document becomes pretty useless. It basically forces you to have a very
> sparse physical address map from 0 to over 40-bit. I wouldn't apply the
> ARM memory maps doc to server systems.

Are you sure? I was under the impression that this document was targetted
specifically at servers.

> >   It's also not just the CPU core, other components also get easily
> >   replaced, like a GICv3 that is not a strict superset of GICv2.
> 
> That's not a problem for Linux, we can describe them in DT or ACPI and
> have drivers. GICv3 has an optional GICv2 compatible mode, though
> vendors may decide not to implement it.

I'm aware that we can deal with it after we have the drivers. My point
was that we are unable to deal with this problem in general if we want
to run existing kernels on new hardware that contains e.g. a GICv4/5/6
that requires a new driver which has to first be written and then
backported into distro kernels.

	Arnd
