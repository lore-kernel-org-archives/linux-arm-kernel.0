From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Apr 2016 11:26:08 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
Message-ID: <20160428092608.GE17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 12:41:29PM +0200, Linus Walleij wrote:
> On Mon, Apr 25, 2016 at 1:57 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Apr 23, 2016 at 11:43:58AM +0200, Linus Walleij wrote:
> >> Hi ARM SoC guys,
> >>
> >> these two patches move the ARM character LCD driver from
> >> misc drivers to the auxdisplay subsystem where it belongs and
> >> updates the defconfig for the RealView accordingly.
> >>
> >> Please pull it into some cleanup branch in the ARM SoC
> >> tree.
> >>
> >> I tried to get some ACK from the auxdisplay maintainer but no
> >> reaction.
> >
> > Auxdisplay is not a new framework, but rather a very old one.
> >
> > It got introduced in 2.6.21, and only received a couple of drivers
> > since.
> 
> Small problem for me, but Robin is submitting a brand new
> auxdisplay driver:
> http://marc.info/?l=linux-kernel&m=146001950512999&w=2
> http://marc.info/?l=linux-kernel&m=146001988013230&w=2

My understanding is that Tomi doesn't want any new fbdev drivers, so
I'm not sure this is the right place for those patches.

> > It seems to be quite redundant with fbdev deferred_io, which itself is
> > almost deprecated these days.
> 
> That is a valid argument for moving cfag12864b* out to
> drivers/video/* I guess, but it has nothing to do with this
> driver whatsoever.
> 
> This driver has nothing to do with fbdev. Nothing at all.
> It so not connected to any framebuffer.
> 
> This driver gets moved to auxdisplay to match the existing
> LCD driver in drivers/auxdisplay/ks0108.c which is a similar
> hardware, driving an LCD that likewise has nothing to do
> with fbdev.

My bad, I thought all auxdisplay drivers were fbdev ones, but I was
wrong, obviously. And now, I don't really know what auxdisplay is
about anymore :)

Still, moving it to a "framework" that has been inactive for so long
(and you even mention it in your PR) doesn't seem like the right move.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/c92d6bec/attachment.sig>
