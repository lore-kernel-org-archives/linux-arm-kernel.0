From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 23:33:09 +0100
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <51E6E107.8020300@wwwdotorg.org>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
 <20130717083003.GA22506@sirena.org.uk>
 <51E6CDEA.7060003@wwwdotorg.org>
 <20130717175701.GY22506@sirena.org.uk>
 <51E6E107.8020300@wwwdotorg.org>
Message-ID: <20130717223309.GZ22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 12:23:03PM -0600, Stephen Warren wrote:
> On 07/17/2013 11:57 AM, Mark Brown wrote:

> > So how do they disable the core support for the older SoCs with the
> > new model?

> They don't; the core support is so small it's not worth having the
> ifdefs in it; just a few K. As such, it seems simpler to just always
> compile in the core support, and remove the need for all the ifdef
> nests in mach-tegra/. The bulk of the differences are different
> drivers for different chips.

So my take on that is that it seems like it's simpler to just have the
core selection since that's just one option for the user to choose and
save all the space for whatever device they're not interested in rather
than having to go through individual drivers disabling the boring SoCs.
It seems more straightfoward from a UI point of view but perhaps I'm not
thinking about it from the right angle?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/ff0e814b/attachment.sig>
