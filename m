From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Dec 2016 09:45:36 +0100
Subject: [linux-sunxi] Re: [RFC PATCH] ARM: dts: sun8i: add simplefb node
 for H3
In-Reply-To: <1777251480557779@web18m.yandex.ru>
References: <20161130220324.3Kg4VPEw@smtp1m.mail.yandex.net>
 <2717236.xBNAaGdqdc@jernej-laptop>
 <20161130203724.a390595df0199ed19069f91d@free.fr>
 <185067972.ij8nq5Ea6J@jernej-laptop>
 <20161130205233.mwfqlfuqg4cefink@lukather>
 <1777251480557779@web18m.yandex.ru>
Message-ID: <20161201084536.syigq46mevwv6cv3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 10:02:59AM +0800, Icenowy Zheng wrote:
> 
> 
> 01.12.2016, 04:52, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Wed, Nov 30, 2016 at 09:41:26PM +0100, Jernej ?krabec wrote:
> >> ?> > > > The only
> >> ?> > > > code left from you is for DE2. HDMI stuff is basically copied from
> >> ?> > > > Rockhip
> >> ?> > > > driver (including EDID reading), TCON code is now reverted to the same
> >> ?> > > > as
> >> ?> > > > it is in sunxi_display.c. I think it is worth to take a look at EDID
> >> ?> > > > code
> >> ?> > > > and compare it.
> >> ?> > >
> >> ?> > > So is the TCON of DE 2.0 identical to the original TCON?
> >> ?> > >
> >> ?> > > If so, we should reuse sun4i-tcon ...
> >> ?> >
> >> ?> > Well, TCON is splitted in two parts (two base addresses), one for HDMI and
> >> ?> > one for TV. However, register offsets are same as before, so I guess
> >> ?> > driver reusage make sense. I think that there are few additional
> >> ?> > registers, but they can be ignored for simplefb.
> >> ?>
> >> ?> The TCON1 of the H3 is not usable (no ckock). Analog TV has its own
> >> ?> clock and I/O area.
> >> ?>
> >>
> >> ?True, H3 user manual can be misleading sometimes. But this doesn't change the
> >> ?fact that TCON0 has same register offsets with same meaning.
> >
> > Then yes, we should definitely share the drivers too. So, in the end,
> > the only thing that is actually new is the display-engine?
> 
> And HDMI PHY on H3 ;-)

Yes, and that one :)

> In my opinion, we should just put sun8i-de2-drm related code into
> drivers/gpu/drm/sun4i/ .  (Or rename the directory to sunxi)

We should definitely reuse the drivers that are already in there for
the TCON and HDMI parts.

I'd have to look at the exact amount of code that would be needed to
support the new display engine, but I guess if it's big, then a
separate folder makes sense, if it isn't, then putting it in sun4i
makes sense (but I'm reluctant to renaming it to sunxi).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/dfa70723/attachment.sig>
