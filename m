From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Oct 2013 15:08:49 -0600
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023195849.GA8828@mithrandir>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
 <20131023193450.GE32563@obsidianresearch.com>
 <20131023195849.GA8828@mithrandir>
Message-ID: <20131023210849.GB2912@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 09:58:50PM +0200, Thierry Reding wrote:

> > Having a flag day where someone goes and churns the DT to remove a !,
> > and then changes the kernel so all old DTs with a ! won't work at all
> > makes this whole thing seem kinda contrary to the basic motivating
> > premis.
> 
> No. Matching doesn't include the ! marker. So if you remove it from DTS
> files and/or drivers, the only thing that goes away is the warning at
> runtime. Feature-wise there should be no difference.

Sounds good
 
> > Also, what happens during development? If you incompatibly change the
> > binding you should change the name, so maybe <version>!marvell,foo is
> > the way to go. 
> > 
> > v1 of the binding is 1!marvell,foo - version 2 is 2!marvell,foo, etc.
> > 
> > When stablized the last bang is kept and the non-bang version is
> > added. The boot warning is supressed once stable no matter the
> > compatible string used in the dt...
> 
> Why would we want to go through all that trouble if we define up front
> that the binding is experimental in the first place? Encoding a version
> number in it somehow entails that earlier versions are still supported
> in some way.

No, certainly not. It just says the binding has changed and every DT
stanza that uses the old version needs to be reviewed and updated.

> But the whole point of experimental bindings is so that we don't have to
> worry about backwards compatibility.

The purpose is to not silently throw users/testers under the bus. A
driver that doesn't bind is much better than a driver that blows up in
some crazy, hard to determine way because the DT binding has been
silently incompatibly changed.

The rule for experimental bindings should be that incompatible changes
to the binding must bump the version number at the same time, clearly
signalling to everyone using that binding that they need to take some
action.

Jason
