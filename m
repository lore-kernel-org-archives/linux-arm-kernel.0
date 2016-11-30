From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Nov 2016 21:52:33 +0100
Subject: [linux-sunxi] Re: [RFC PATCH] ARM: dts: sun8i: add simplefb node
 for H3
In-Reply-To: <185067972.ij8nq5Ea6J@jernej-laptop>
References: <20161130220324.3Kg4VPEw@smtp1m.mail.yandex.net>
 <2717236.xBNAaGdqdc@jernej-laptop>
 <20161130203724.a390595df0199ed19069f91d@free.fr>
 <185067972.ij8nq5Ea6J@jernej-laptop>
Message-ID: <20161130205233.mwfqlfuqg4cefink@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 09:41:26PM +0100, Jernej ?krabec wrote:
> > > > > The only
> > > > > code left from you is for DE2. HDMI stuff is basically copied from
> > > > > Rockhip
> > > > > driver (including EDID reading), TCON code is now reverted to the same
> > > > > as
> > > > > it is in sunxi_display.c. I think it is worth to take a look at EDID
> > > > > code
> > > > > and compare it.
> > > > 
> > > > So is the TCON of DE 2.0 identical to the original TCON?
> > > > 
> > > > If so, we should reuse sun4i-tcon ...
> > > 
> > > Well, TCON is splitted in two parts (two base addresses), one for HDMI and
> > > one for TV. However, register offsets are same as before, so I guess
> > > driver reusage make sense. I think that there are few additional
> > > registers, but they can be ignored for simplefb.
> > 
> > The TCON1 of the H3 is not usable (no ckock). Analog TV has its own
> > clock and I/O area.
> > 
> 
> True, H3 user manual can be misleading sometimes. But this doesn't change the 
> fact that TCON0 has same register offsets with same meaning.

Then yes, we should definitely share the drivers too. So, in the end,
the only thing that is actually new is the display-engine?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161130/dbe6e562/attachment.sig>
