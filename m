From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 May 2014 20:06:34 -0500
Subject: [linux-sunxi] Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add
 AXP209 support to various boards
In-Reply-To: <CAOQ7t2ay7UNiCZyUw4RrQ+4O1CYUht32U_OSYkbVWRLUq8_hZw@mail.gmail.com>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
 <20140503010936.GF4090@lukather>
 <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
 <20140505225139.GD9464@lukather>
 <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
 <20140508025337.GI7047@lukather>
 <CAOQ7t2ay7UNiCZyUw4RrQ+4O1CYUht32U_OSYkbVWRLUq8_hZw@mail.gmail.com>
Message-ID: <20140510010634.GG7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 10:17:16AM +0200, Carlo Caione wrote:
> On Thu, May 8, 2014 at 4:53 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> <snip>
> 
> > What I mean is that no information is still better than wrong
> > informations. If you don't have the schematics, then don't do anything
> > on this boards. Hopefully, someone with more infos on this will know
> > what to do.
> 
> I partially agree here. Not specifying the voltage range for the
> regulators but only keeping them always-on from a practical point of
> view means that we do nothing with those regulators (see also
> https://www.mail-archive.com/linux-input at vger.kernel.org/msg09532.html
> )

But we don't even know if they are used on these boards or not in the
first place..

> > Moreover, I have the feeling that you just copy pasted all the
> > informations on this patch. The first example I'm seeing is the
> > cubieboard, for which we do have the schematics, and this patch says
> > that ldo4 is used for HDMI, and that is required to stays always on,
> > while LDO4 doesn't seem to be used at all, and that HDMI takes
> > directly its input source from DC-5V.
> 
> The names for the regulators are taken from the original Allwinner
> driver and (of course) they can have nothing to do with the function
> they have in the board. I agree that this could be misleading so I'll
> change them with more general names. Concerning LDO4 that is always
> on, it was off until this v4, but I changed it back to have one common
> DT representation among all the boards.

I'm sorry, you did a great job on this PMIC driver, but this is just
wrong. I'm completely fine with the names. What I'm not fine with is
all this "one common DT representation across all boards". Pretty much
all the boards are wired differently when it comes to regulators. Why
do you want to just do some copy pasting without any checking on the
schematics side if not just for the joy of duplicating code?

> > I guess you need some more refining on this patch.
> 
> Ok, I'll submit a v6 only for this patch.

Please, please, *please* make sure that the informations you put in
there are actually accurate.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/abd40966/attachment.sig>
