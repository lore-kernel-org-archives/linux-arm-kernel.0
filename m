From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 19 Jun 2015 10:24:07 +0200
Subject: [PATCH v7 04/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150619064256.GA10246@gondor.apana.org.au>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434635190-27733-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150619064256.GA10246@gondor.apana.org.au>
Message-ID: <20150619102407.01187ff0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Herbert,

On Fri, 19 Jun 2015 14:42:56 +0800, Herbert Xu wrote:
> On Thu, Jun 18, 2015 at 03:46:20PM +0200, Boris Brezillon wrote:
> >
> > +	dram = mv_mbus_dram_info_nooverlap();
> 
> This doesn't compile because it hasn't made it into mainline yet.
> I'm afraid this patch-set will have to wait until that happens.

We have two options here:

 1/ We can ask the mach-mvebu maintainers to provide a branch with just
    the commit implementing mv_mbus_dram_info_nooverlap(), and you
    merge that branch into your tree as a dependency.

 2/ We temporarily revert back to using mv_mbus_dram_info(). For the
    vast majority of platforms, this is OK. It's only if you have 4 GB
    of RAM or more that it causes problem. And then we switch to
    mv_mbus_dram_info_nooverlap() as part of the -rc cycle.

(2) is probably easier. Herbert, what do you think?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
