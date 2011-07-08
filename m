From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jul 2011 00:39:12 -0600 (MDT)
Subject: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
In-Reply-To: <20110707055549.GC15815@atomide.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
	<4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com>
Message-ID: <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Tony Lindgren wrote:

> * Rajendra Nayak <rnayak@ti.com> [110706 22:26]:
> > On 7/6/2011 12:19 AM, Paul Walmsley wrote:
> > >
> > >Patch 16, to me, belongs best with the 4460 support series and so I'll see
> > >if it makes sense to fit it in there somewhere.
> > 
> > Paul,
> > 
> > Do you want me to base the 4460 support series on one of your branches
> > and re-post including the above patch?
> 
> Do we really need to do that patching right now to add base 4460 support?
> 
> If we're just doing a bunch of renames all over the place to add support
> for a new processor variant, something is wrong. This is exactly the kind
> of "crazy churn" Linus was complaining about. In this case the crazy churn
> is "let's rename 4430 to 44XX all over the place".
> 
> To me it's sane to assume that we can have most of 4430 features on 4460
> and don't need to rename 4430 to 44XX for that. Adding 4460 should be
> just add few new 4460 defines, then do an arch_initcall to fixup things
> between 4430 and 4460.
> 
> It would be nice to get the base 4460 support merged as the patches look
> ready to go otherwise. Rajendra, I suggest you take a quick look and see
> if you can leave out the dependency to the 4430 to 44XX rename patch to
> add minimal 4460 support. Then we can patch in the missing features later
> on, most likely we don't even need the arch_initcall fixup initially either.
> 
> This would also leave out the dependency between the various patch
> series which will always lead into issues with merging code. Changes to
> the infrastructure issues like this should have been patched away early.
> The merge window is about to start and we're still waiting for the
> dependencies to get sorted out.

Rajendra's patch series doesn't require the 4430 -> 44XX changes in the 
PRM/CM macros (Beno?t's patch 16).  That patch can be put in a separate 
series, if you like.  

It does require changing CHIP_IS_OMAP4430 to CHIP_IS_OMAP44XX in the 
powerdomains, clockdomains, etc.  To me, that seems reasonable since the 
4460 isn't simply a die shrink, it has some other changes on it; but I 
guess you have a different view on that.

I will add acks/reviewed-by:s on the 4460 patches, and maybe you can 
decide which ones you'd like to merge, if any.


- Paul
