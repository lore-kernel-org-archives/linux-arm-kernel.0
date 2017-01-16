From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Jan 2017 17:31:24 +0100
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
 <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
 <20170105224210.wfinfucbpkkd44om@lukather>
 <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
Message-ID: <20170116163124.c5gusyd3j3goivnf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 12:16:00AM +0000, Andr? Przywara wrote:
> On 05/01/17 22:42, Maxime Ripard wrote:
> > On Fri, Dec 30, 2016 at 01:55:44PM +0100, Linus Walleij wrote:
> >> On Mon, Dec 26, 2016 at 3:33 PM, Andr? Przywara <andre.przywara@arm.com> wrote:
> >>
> >>> So while this patch technically looks correct, I was wondering if we
> >>> should really explore the possibility of making the whole of sunxi
> >>> pinctrl DT controlled.
> >>> I brought this up a while ago, but people weren't overly enthusiastic
> >>> about it, though their argument weren't really convincing to me[1].
> >>>
> >>> So:
> >>> As this "driver" here is basically a table linking GPIO bit settings
> >>> (the actual mux value) to names and every pin we care about needs to be
> >>> enumerated in the DT anyway, why not just add something like:
> >>> allwinner,pinmux = <4>;
> >>> to each pin(group) in the DT and get rid of this "driver" file here
> >>> entirely?
> >>
> >> I'm open to that if you can use pinctrl-single which is in the kernel
> >> for this purpose only, and is used with both OMAPs and HiSilicon.
> > 
> > I'm not open to that, and I'm getting tired of discussing it over and
> > over again. Andre, if you want to be convinced again, please read the
> > last discussion we had on this topic.
> 
> As I said: It didn't convince me back then. And frankly we didn't really
> discuss it back then, I just refrained from entering a discussion
> against _two_ maintainers at this time, since my capacity on this kind
> of email threads is really very limited - especially for something that
> is a hobby to me.

This is also (mostly) a hobby to me, which is exactly why I prefer to
work on something actually useful, rather than just discussing this
over and over again. Just like I don't want (myself, or anyone,
really, since we're all in the same boat) to have to maintain two
separate pinctrl drivers.

We're having a documented, simple, pinctrl binding, using the generic
bindings now (that almost everyone else is using now, or is very close
to), and we can leverage as much documentation and code from that. Why
would we want to create and maintain a new driver with a new binding,
that will need to be documented again, learned by everyone, and will
lead only to confusion across the people who just want to have their
board supported?

And imagine the kind of mess we would be in if everyone getting a bit
involved in the support of one platform at one point wanted to trash
one big part of its infrastructure and start all over again because he
likes it better this way.

I'm sorry, but this is also our jobs as maintainers to prevent all
these kind of issues, and to maintain consistency. Switching to one
binding to another breaks that consistency on many level, both in
pinctrl and in the platform support itself. So sorry, but that's not
going to happen.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170116/e4bf707c/attachment.sig>
