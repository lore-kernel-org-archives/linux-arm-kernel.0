From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Oct 2013 13:34:50 -0600
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023185909.GC7863@ulmo.nvidia.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
Message-ID: <20131023193450.GE32563@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:59:10PM +0200, Thierry Reding wrote:

> > I'd say yes. Going from unstable to stable is quite a step for a binding
> > and that should be visible and worth a patch IMO. Also, when looking at
> > a DTS file or some driver code, it will avoid
> > confusion/misinterpretation if one can see immediately the status of a
> > binding.
> 
> Yes, I fully agree. It might look like churn, but I think this could
> actually be a part of the formal process to stabilize a binding. It
> would be final step of that process, actually.

I actually think this makes things worse.

Ostensibly the purpose of stable DT is to allow the DT and kernel to
be separate, so you should minimize the churn in the DTs, and they
should trend to stable.

Having a flag day where someone goes and churns the DT to remove a !,
and then changes the kernel so all old DTs with a ! won't work at all
makes this whole thing seem kinda contrary to the basic motivating
premis.

Also, what happens during development? If you incompatibly change the
binding you should change the name, so maybe <version>!marvell,foo is
the way to go. 

v1 of the binding is 1!marvell,foo - version 2 is 2!marvell,foo, etc.

When stablized the last bang is kept and the non-bang version is
added. The boot warning is supressed once stable no matter the
compatible string used in the dt...

Jason
