From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 21 Jun 2016 07:56:41 +0000
Subject: [PATCH v2] arm: tegra124: remove commas from unit addresses
In-Reply-To: <20160620171124.GA6333@ulmo.ba.sec>
References: <1466298275-15753-1-git-send-email-marcel.ziswiler@toradex.com>
 <576810C2.1030401@wwwdotorg.org> <20160620164057.GD6175@ulmo.ba.sec>
 <57681DC3.9090801@wwwdotorg.org> <20160620171124.GA6333@ulmo.ba.sec>
Message-ID: <1466495800.4742.1.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-20 at 19:11 +0200, Thierry Reding wrote:
> On Mon, Jun 20, 2016 at 10:45:55AM -0600, Stephen Warren wrote:
> > 
> > On 06/20/2016 10:40 AM, Thierry Reding wrote:
> > > 
> > > On Mon, Jun 20, 2016 at 09:50:26AM -0600, Stephen Warren wrote:
> > > > 
> > > > On 06/18/2016 07:04 PM, Marcel Ziswiler wrote:
> > > > > 
> > > > > Remove commas from unit addresses as suggested by Rob Herring
> > > > > upon me
> > > > > posting initial Apalis TK1 support:
> > > > > 
> > > > > http://article.gmane.org/gmane.linux.ports.tegra/26608
> > > > Acked-by: Stephen Warren <swarren@nvidia.com>
> > > I'm confused now. I posted almost exactly the same patch a while
> > > ago and
> > > we agreed that we couldn't do this because the node names were to
> > > be
> > > considered part of the ABI.
> > > 
> > > Is it or is it not?
> > The particular case where it matters is the GPU node, which U-Boot
> > manipulates. This revised patch version no longer renames the GPU
> > node and
> > so in practice avoids any issues that I'm aware of.
> > 
> > If there's a more general rule that node names are part of the ABI,
> > then
> > indeed we shouldn't take this patch.
> I'm somewhat uncomfortable with this notion. Just because we don't
> know
> of any other cases doesn't mean there aren't any. My understanding is
> that it's fairly common to look up device tree nodes by name, however
> brittle that may be.
> 
> There's also the matter of consistency to consider here. I suspect
> that
> if we make this change somebody will notice the odd one out and send
> patches to "fix it up". So if we get confirmation about this change
> being okay, I'd request that a comment be added to the GPU node as to
> why it is not converted.

Sure, let me add such a comment in a v3 that it is crystal clear why we
did so.

> Thierry


Thanks Thierry.

Cheers

Marcel
