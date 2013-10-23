From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 21:58:50 +0200
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023193450.GE32563@obsidianresearch.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
 <20131023193450.GE32563@obsidianresearch.com>
Message-ID: <20131023195849.GA8828@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 01:34:50PM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2013 at 08:59:10PM +0200, Thierry Reding wrote:
> 
> > > I'd say yes. Going from unstable to stable is quite a step for a binding
> > > and that should be visible and worth a patch IMO. Also, when looking at
> > > a DTS file or some driver code, it will avoid
> > > confusion/misinterpretation if one can see immediately the status of a
> > > binding.
> > 
> > Yes, I fully agree. It might look like churn, but I think this could
> > actually be a part of the formal process to stabilize a binding. It
> > would be final step of that process, actually.
> 
> I actually think this makes things worse.
> 
> Ostensibly the purpose of stable DT is to allow the DT and kernel to
> be separate, so you should minimize the churn in the DTs, and they
> should trend to stable.

Well, I do think that stable DT has benefits. And quite frankly I think
the majority of bindings will eventually converge to some stable state
anyway, if only because active development stops. In an ideal world that
would be when a product ships.

So this proposal isn't so much about making a decision for stable or
experimental DT, but rather about giving users a choice. If they are
willing to live with the additional "burden" of updating the DTB every
once in a while, then they can enable the option and get additional
functionality. If they don't want any part of that, they can just leave
the option disabled and only get the parts that are stable.

> Having a flag day where someone goes and churns the DT to remove a !,
> and then changes the kernel so all old DTs with a ! won't work at all
> makes this whole thing seem kinda contrary to the basic motivating
> premis.

No. Matching doesn't include the ! marker. So if you remove it from DTS
files and/or drivers, the only thing that goes away is the warning at
runtime. Feature-wise there should be no difference.

> Also, what happens during development? If you incompatibly change the
> binding you should change the name, so maybe <version>!marvell,foo is
> the way to go. 
> 
> v1 of the binding is 1!marvell,foo - version 2 is 2!marvell,foo, etc.
> 
> When stablized the last bang is kept and the non-bang version is
> added. The boot warning is supressed once stable no matter the
> compatible string used in the dt...

Why would we want to go through all that trouble if we define up front
that the binding is experimental in the first place? Encoding a version
number in it somehow entails that earlier versions are still supported
in some way.

But the whole point of experimental bindings is so that we don't have to
worry about backwards compatibility.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/d68c7d35/attachment-0001.sig>
