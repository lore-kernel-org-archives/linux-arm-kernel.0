From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 12:50:39 +0000
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
In-Reply-To: <51139E63.2030302@ti.com>
References: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
 <201302071155.12565.arnd@arndb.de> <51139E63.2030302@ti.com>
Message-ID: <201302071250.39923.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Tomi Valkeinen wrote:
> > I would suggest only the first patch, since Linus quite specifically
> > asked only for serious bug fixes. I think an allyesconfig build
> > breakage is serious enough, but doing multiple patches for one
> > bug should not be necessary and is much harder to justify.
> 
> Well, as I see, the bug is omapdrm using "select", not "depends on". So
> if I'd have to pick one patch, I'd send 0003. That would fix allyesconfig.
> 
> Applying only 0003 means that omapdrm (and omapdss) won't be built on
> ARCH_MULTIPLATFORM, but building omapdrm on ARCH_MULTIPLATFORM is a
> feature added in this merge window, so leaving it out is not a regression.
> 
> But I'm not sure if I'm being overly pedantic here. Patch 0001 would fix
> allyesconfig, and allow building omapdrm with ARCH_MULTIPLATFORM.
> However, the fixing there happens as a side effect, and so the 0001
> patch isn't even called a "fix" in its subject. That's the reason I'm a
> bit reluctant with the 0001 patch as a fix.

Makes sense. I suggested the same initially, but Rob preferred enabling
DSS on multiplatform as well, since he wants to see broad build coverage
for the DRM part. We should probably do that in 3.9, but for 3.8,
just changing DRM to depend on DSS seems like the least intrusive
choice.

	Arnd
