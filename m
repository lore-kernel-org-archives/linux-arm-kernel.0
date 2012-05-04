From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 18:49:51 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120504160545.GT27023@stoneboat.aleph1.co.uk>
References: <201205031350.35476.arnd@arndb.de>
 <201205041517.58830.arnd@arndb.de>
 <20120504160545.GT27023@stoneboat.aleph1.co.uk>
Message-ID: <201205041849.52046.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Wookey wrote:
> > This is very important because distros are obviously the primary consumer
> > of multiplatform builds (aside from build testing). The goal should very
> > much be to reduce the number of distinct kernels that folks like debian,
> > fedora or cyanogenmod have to build.
> 
> Just to be clear, we'd very much like to support more hardware, ideally
> 'everything a significant number of people have', but the overhead to
> the whole distro for each new kernel added to the build (for every
> upload, slowing and potentially breaking releases on all arches) is
> sufficiently high that we have been strict about what is supported. As
> a result a lot of people use Debian with non-distro kernels.

Right, and this is the main motivation behind starting the multiplatform
kernel anyway: supporting more hardware with fewer kernels. Other distros
already aim at supporting only one ARM kernel binary, like things are
on other architectures. One related issue is the kernel binary size, which
we haven't discussed here yet. If we want to build 200 board files into
the kernel, that alone becomes a burden, even if most of it can be discarded
from RAM after the initcalls are done. Supporting only DT-enabled machines
can significantly reduce the size while only reducing the number of supported
boards by a bit, I'd hope.

> Obviously missing things are tegra, dove/armada, omap4. Freerunner
> would have been nice a while back but probably a bit late now. 

I can think of a few more: vexpress would be nice for running something
useful inside of KVM when we get there, various samsung socs are used
in cheap tablet PCs, and stuff like highbank is becoming more relevant
for distros now on the server side.

> It's not clear to me how many omap platforms our 'omap' kernel
> actually serves in practice, and similarly for the other 'generic'
> kernels.
> 
> Obviously any and all progress in the direction of making existing
> coverage or expanded coverage easier/faster/more-reliable/simpler is
> very welcome. 

	Arnd
