From: carlo@caione.org (Carlo Caione)
Date: Thu, 8 May 2014 10:17:16 +0200
Subject: [linux-sunxi] Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
In-Reply-To: <20140508025337.GI7047@lukather>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
 <20140503010936.GF4090@lukather>
 <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
 <20140505225139.GD9464@lukather>
 <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
 <20140508025337.GI7047@lukather>
Message-ID: <CAOQ7t2ay7UNiCZyUw4RrQ+4O1CYUht32U_OSYkbVWRLUq8_hZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 4:53 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

<snip>

> What I mean is that no information is still better than wrong
> informations. If you don't have the schematics, then don't do anything
> on this boards. Hopefully, someone with more infos on this will know
> what to do.

I partially agree here. Not specifying the voltage range for the
regulators but only keeping them always-on from a practical point of
view means that we do nothing with those regulators (see also
https://www.mail-archive.com/linux-input at vger.kernel.org/msg09532.html
)

> Moreover, I have the feeling that you just copy pasted all the
> informations on this patch. The first example I'm seeing is the
> cubieboard, for which we do have the schematics, and this patch says
> that ldo4 is used for HDMI, and that is required to stays always on,
> while LDO4 doesn't seem to be used at all, and that HDMI takes
> directly its input source from DC-5V.

The names for the regulators are taken from the original Allwinner
driver and (of course) they can have nothing to do with the function
they have in the board. I agree that this could be misleading so I'll
change them with more general names. Concerning LDO4 that is always
on, it was off until this v4, but I changed it back to have one common
DT representation among all the boards.

> I guess you need some more refining on this patch.

Ok, I'll submit a v6 only for this patch.

Thanks,

-- 
Carlo Caione
