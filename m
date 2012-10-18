From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Oct 2012 09:58:11 +0900
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <201210171342.29635.arnd@arndb.de>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
 <201210171342.29635.arnd@arndb.de>
Message-ID: <20121018005811.GA4325@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 01:42:29PM +0000, Arnd Bergmann wrote:
> On Wednesday 17 October 2012, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > please consider the following defconfig enhancements for 3.8.
> 
> These look good to me, but I wonder what happened to the plan to reduce
> the number of defconfig files we discussed before. Since you can build
> a combined kernel that runs on all (or most) of the supported boards,
> can you add a combined shmobile_defconfig that is able to work on
> a wide variety of hardware and drop some of the less common defconfig
> files?
> 
> Most of the modern platforms nowadays have just one defconfig that
> covers everything.

Hi Arnd,

I wonder if such consolidation only makes sense for boards that
make use of DT. If so, I can see that we may be able to come
up with a single configuration for the Armadillo800eva, KZM9G
and KZM9D boards. But not for older boards such as the Mackerel which
have not been converted to use DT.

I am also wondering if more of the drivers that SH Mobile uses need to
become DT aware before a consolidated configuration can work.  In
particular, I am thinking about the SCI serial driver and the location of
the serial port that can be used for serial console and early printk - this
features in the kernel command line of the per-board defconfigs and is
relied on by developers.
