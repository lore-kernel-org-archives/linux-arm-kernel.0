From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 24 Oct 2013 09:34:59 +0100
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023172001.GA3379@katana>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
Message-ID: <20131024083459.48FE3C4039D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013 18:20:02 +0100, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> > Do we really want to polute the drivers and DT files with a ! in the
> > compatible values? I thought we'd considered that, but chosen having the
> > drivers that use unstable bindings depend on a Kconfig option as an
> > alternative, not an additional step?
> 
> I'd even go further and use "unstable-" as the prefix instead of "!"
> which is way more explicit.
> 
> 
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

No, it shouldn't. Going from unstable to stable is not a large step, rather it is coming to the point of looking around and realizing that the binding is working quite well.

I don't think the solution is to put this into the kernel to be checked
at runtime. The better solution is to put it into DTC and make it
complain (either warn or error; depending on build config?) about usage
of compatible strings that are marked in the binding documentation as
unstable.

g.
