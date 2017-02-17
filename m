From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 17 Feb 2017 16:44:19 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <CACvgo51p+aqegjkbF6jGggwr+KXq_71w0VFzJvFAF6_egT1-kA@mail.gmail.com>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <CACvgo51p+aqegjkbF6jGggwr+KXq_71w0VFzJvFAF6_egT1-kA@mail.gmail.com>
Message-ID: <20170217154419.xr4n2ikp4li3c7co@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 04:54:45PM +0000, Emil Velikov wrote:
> On 16 February 2017 at 12:43, Tobias Jakobi
> <tjakobi@math.uni-bielefeld.de> wrote:
> > Hello,
> >
> > I was wondering about the following. Wasn't there some strict
> > requirement about code going upstream, which also included that there
> > was a full open-source driver stack for it?
> >
> > I don't see how this is the case for Mali, neither in the kernel, nor in
> > userspace. I'm aware that the Mali kernel driver is open-source. But it
> > is not upstream, maintained out of tree, and won't land upstream in its
> > current form (no resemblence to a DRM driver at all). And let's not talk
> > about the userspace part.
> >
> > So, why should this be here?
> >
> Have to agree with Tobias, here.
> 
> I can see the annoyance that Maxime and others have to go through to
> their systems working.
> At the same time, changing upstream kernel to suit out of tree
> module(s) is not how things work. Right ?
> 
> Not to mention that the series adds stable ABI exclusively(?) used by
> a module which does not seem to be in the process of getting merged.

It really doesn't have any relation to whether a particular component
is supported in Linux. Our git repo just happens to be the canonical
source of DT, but those DTs are also used in other systems and
projects that have *no* relation with Linux, and might have a
different view on things than we do.

There's been a long-running discussion about moving the DTs out of the
kernel and in a separate repo. Would you still be opposed to it if I
happened to contribute that binding to that repo, even if Linux didn't
have any in-tree support for it? I'm pretty sure you wouldn't, yet
this is the exact same case.

And taking the ACPI example once again, this doesn't seem to bother
you at all that ACPI reports that it has a device that is not
supported in-tree in Linux. Why is it any different in DT.

We already have DT bindings for out of tree drivers, there's really
nothing new here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170217/63ac141b/attachment.sig>
