From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Feb 2016 15:52:55 +0000
Subject: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <20160211150806.GS19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
 <20160211150806.GS19432@atomide.com>
Message-ID: <20160211155255.GA1953@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 07:08:06AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [160211 03:52]:

> > Why, I'm not seeing any dependencies here?  I'd also expect to be seeing
> > an awful lot more changes like this, this shouldn't be an OMAP thing -
> > do we need to fix the core API and then roll out the transition in a
> > different way?

> Please feel free to pick up this one if you have other fixes
> lined up, nothing stopping that.

I'll take it myself unless there is a strong reason to merge it as part
of another series.

> There will be likely more fixes like this to make drivers follow
> the PM runtime API documentation. These were just the initial
> ones that were obvious.

This does sound like there's been a change in the interface compared to
what users are actually doing - is this an actual problem or is it just
a divergence from docs?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/290ead7c/attachment-0001.sig>
