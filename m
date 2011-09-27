From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 27 Sep 2011 15:08:49 -0600
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <201109271550.36427.arnd@arndb.de>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110926152634.GN2946@opensource.wolfsonmicro.com>
	<CACxGe6swdnhk_GCAv3siSx4kxNQXmCLDbwBFjsX5VPNfCBc2Mg@mail.gmail.com>
	<201109271550.36427.arnd@arndb.de>
Message-ID: <20110927210849.GD3994@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:50:36PM +0200, Arnd Bergmann wrote:
> On Monday 26 September 2011, Grant Likely wrote:
> > Actually, in the next iteration, I'm thinking it would be a good idea
> > to create a new #define to only be used by probe deferral.  I want it
> > to be easy to find all the drivers that are using this mechanism
> > without needing to filter all the unrelated hits.  However, this is a
> > kernel-only thing so it is probably not appropriate to add it to
> > include/asm-generic/errno.h.  I could use some guidance/advice as to
> > the best way to handle this.
> 
> include/linux/errno.h already has a bunch of kernel-internal error
> codes that are never supposed to be seen in user space. Just
> add one there, the next free one right now is 517, after
> ERESTART_RESTARTBLOCK.

Okay, will do.  How does EPROBE_DEFER 518 sound?

g.
