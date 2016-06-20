From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jun 2016 19:11:24 +0200
Subject: [PATCH v2] arm: tegra124: remove commas from unit addresses
In-Reply-To: <57681DC3.9090801@wwwdotorg.org>
References: <1466298275-15753-1-git-send-email-marcel.ziswiler@toradex.com>
 <576810C2.1030401@wwwdotorg.org>
 <20160620164057.GD6175@ulmo.ba.sec>
 <57681DC3.9090801@wwwdotorg.org>
Message-ID: <20160620171124.GA6333@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 10:45:55AM -0600, Stephen Warren wrote:
> On 06/20/2016 10:40 AM, Thierry Reding wrote:
> > On Mon, Jun 20, 2016 at 09:50:26AM -0600, Stephen Warren wrote:
> > > On 06/18/2016 07:04 PM, Marcel Ziswiler wrote:
> > > > Remove commas from unit addresses as suggested by Rob Herring upon me
> > > > posting initial Apalis TK1 support:
> > > > 
> > > > http://article.gmane.org/gmane.linux.ports.tegra/26608
> > > 
> > > Acked-by: Stephen Warren <swarren@nvidia.com>
> > 
> > I'm confused now. I posted almost exactly the same patch a while ago and
> > we agreed that we couldn't do this because the node names were to be
> > considered part of the ABI.
> > 
> > Is it or is it not?
> 
> The particular case where it matters is the GPU node, which U-Boot
> manipulates. This revised patch version no longer renames the GPU node and
> so in practice avoids any issues that I'm aware of.
> 
> If there's a more general rule that node names are part of the ABI, then
> indeed we shouldn't take this patch.

I'm somewhat uncomfortable with this notion. Just because we don't know
of any other cases doesn't mean there aren't any. My understanding is
that it's fairly common to look up device tree nodes by name, however
brittle that may be.

There's also the matter of consistency to consider here. I suspect that
if we make this change somebody will notice the odd one out and send
patches to "fix it up". So if we get confirmation about this change
being okay, I'd request that a comment be added to the GPU node as to
why it is not converted.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/0f13c31c/attachment-0001.sig>
