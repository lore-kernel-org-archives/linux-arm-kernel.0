From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 20:59:10 +0200
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023172001.GA3379@katana>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
Message-ID: <20131023185909.GC7863@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 06:20:02PM +0100, Wolfram Sang wrote:
> 
> > Do we really want to polute the drivers and DT files with a ! in the
> > compatible values? I thought we'd considered that, but chosen having the
> > drivers that use unstable bindings depend on a Kconfig option as an
> > alternative, not an additional step?
> 
> I'd even go further and use "unstable-" as the prefix instead of "!"
> which is way more explicit.

I guess unstable- is as good as anything. I personally think that "!" is
disturbing enough to the eye to make it abundantly clear that something
is fishy.

> > The one issue with doing this is that if a binding is thought to be
> > unstable, but becomes stable later without any changes, we'll have to do
> > busy-work to remove the ! in all the DT files, thus artificially
> > introducing an incompatibility. Perhaps that's fine though?
> 
> I'd say yes. Going from unstable to stable is quite a step for a binding
> and that should be visible and worth a patch IMO. Also, when looking at
> a DTS file or some driver code, it will avoid
> confusion/misinterpretation if one can see immediately the status of a
> binding.

Yes, I fully agree. It might look like churn, but I think this could
actually be a part of the formal process to stabilize a binding. It
would be final step of that process, actually.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/3e27bbdc/attachment.sig>
