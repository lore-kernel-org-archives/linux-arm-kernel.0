From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Jan 2013 21:13:15 +0800
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359131057.32148.9.camel@linux-builds1>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
 <20130125154955.GD10055@amd.pavel.ucw.cz>
 <1359131057.32148.9.camel@linux-builds1>
Message-ID: <20130128131312.GB20238@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 10:24:17AM -0600, Dinh Nguyen wrote:
> Hi Pavel,
> On Fri, 2013-01-25 at 16:49 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > mach-socfpga is another platform that needs to use
> > > v7_invalidate_l1 to bringup additional cores. There was a comment that
> > > the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> > 
> > If there are three copies of code, with fourth one needed for next
> > platform, moving it into common code makes sense.
> > 
> > But... The code was not identical before the merge. Are you sure that
> > the differences do not hurt? At the very least, it should be mentioned
> > in the changelog.
> 
> Indeed, the addition of 
> 
> mcr     p15, 0, r0, c7, c5, 0   @ invalidate I cache
> 
This becomes unnecessary since commit 612539e (ARM: 7296/1: proc-v7.S:
remove HARVARD_CACHE preprocessor guards) gets in.

Shawn

> was done by commit # 5b2acf384c8a8707d32a98106192ee7187e4446d
> 
> This adds invalidate I-Cache as well as D-Cache, which I think should be
> ok for most platforms. 
> 
