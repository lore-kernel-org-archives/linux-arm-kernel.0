From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 16:32:28 -0400
Subject: DT bindings as ABI [was: Do we have people interested in
 device tree janitoring / cleanup?]
In-Reply-To: <CAL_Jsq+vWbTb8wNEDCR2c_M6sBnKW6e5HGk48QzmXSujQUdddA@mail.gmail.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
 <CAL_Jsq+vWbTb8wNEDCR2c_M6sBnKW6e5HGk48QzmXSujQUdddA@mail.gmail.com>
Message-ID: <20130725203228.GX23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:16:14PM -0500, Rob Herring wrote:
> On Thu, Jul 25, 2013 at 2:31 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Thu, Jul 25, 2013 at 02:11:31PM -0500, Rob Herring wrote:
> >> On Thu, Jul 25, 2013 at 11:09 AM, Olof Johansson <olof@lixom.net> wrote:
> >
> >> > One problem that needs to be solved is obviously how a binding
> >> > graduates from tentative to locked. This work isn't going to be very
> >> > interesting to most people, I suspect. Think standards committee type
> >> > work.
> >>
> >> I think a time based stabilization period would be better than a
> >> separate directory to apply bindings too. Or time plus periodic review
> >> perhaps.
> >
> > The only problem with a time-based versus separate directory is how do
> > users who've downloaded the tree determine which bindings are stable?
> > If they pull a tarball, or receive an SDK, there is most likely no git
> > history attached.
> 
> Well, if time based includes moving the binding out of the kernel,
> then that is what defines it as stable or not. I guess that is a form
> of a separate directory.

One of the things I've been trying to square up in my head is how to
retain the history of the binding when moving to the new tree.  My
current idea was to clone the kernel tree, add one patch deleting
everything but the bindings and dts files, and one more patch moving
things where we want them (arch/{powerpc,arm}/boot/dts -> dts).

Then, as needed, we could merge a kernel version tag and delete
everything we don't need (code) in the merge commit.

The downside of this is it would be messy, the upside is that we could
closely track the kernel tree (until the bindings and dts are moved
out), and retain the history of the bindings and dts files.

> I don't think we want to be moving bindings twice: tentative -> stable
> and kernel -> DT repo.

agreed.

> The policy could be as simple as an binding without change in at least
> N kernel releases is moved out and stable.

If the cloned tree idea works, we could just merge version tags that are
two or three behind the most recent version.

thx,

Jason.
