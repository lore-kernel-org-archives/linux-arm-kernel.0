From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 19:46:33 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <alpine.LFD.2.02.1205161246080.1640@xanadu.home>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205161528.27318.arnd@arndb.de>
 <alpine.LFD.2.02.1205161246080.1640@xanadu.home>
Message-ID: <201205161946.34179.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Nicolas Pitre wrote:
> > 
> > AFAICT, those are shared between most of those socs, and I would not want
> > to change the code in them to the new name.
> 
> Why not?  Module aliases can be used if that is a concern.
> 
> > If we change the directory
> > name to something completely different, it no longer matches the driver
> > names.
> 
> I wouldn't consider this as a major concern.  For example, the ethernet 
> driver that all those SOCs use is not called "orion".

It's not a big thing, I just feel that leaving the drivers alone makes
it a bit easier to port patches between kernel versions. Another argument
for orion is that it's nicer to read as a function name prefix than
mrvl_ebu_* as you suggested. The main counterargument to keeping orion_
as I understand it is that it's actually only the name for the oldest
members of this family, right? This is a good point, but we also have
a lot of other cases in the kernel where code is named after the first
thing that used it, e.g. arch/x86 was called arch/i386 for a long time
and we still have tons of references to that.

	Arnd
