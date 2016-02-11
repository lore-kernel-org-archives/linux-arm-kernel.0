From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Feb 2016 18:36:40 +0000
Subject: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <20160211173620.GU19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
 <20160211150806.GS19432@atomide.com>
 <20160211155255.GA1953@sirena.org.uk>
 <20160211173620.GU19432@atomide.com>
Message-ID: <20160211183640.GB1953@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 09:36:20AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [160211 07:54]:

> > This does sound like there's been a change in the interface compared to
> > what users are actually doing - is this an actual problem or is it just
> > a divergence from docs?

> It's an actual problem at least on omaps as the omap_device code
> is very picky about the hardware state.

> Depending how the PM runtime is implemented, it may be a problem
> for some other cases too.

Or people just aren't testing mainline that well (if this is broken in
v4.5 that suggests nobody noticed in -next) - do you know when this
broke?  It really seems like we may need to spin round on how this is
deployed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/f1717419/attachment.sig>
