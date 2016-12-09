From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Dec 2016 10:36:57 +0100
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <CAGb2v65uTH_PD28KqAhhzkE5zhLt54GUb7xXNxxe0xHW0A+xjQ@mail.gmail.com>
References: <20161124112231.4297-1-wens@csie.org>
 <20161206172911.z6sbjzgqv3vfcrfh@lukather>
 <CAGb2v65uTH_PD28KqAhhzkE5zhLt54GUb7xXNxxe0xHW0A+xjQ@mail.gmail.com>
Message-ID: <20161209093657.jcalemg5xpumr2ma@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 10:26:25AM +0800, Chen-Yu Tsai wrote:
> > Some panels require an exact frequency, some have a minimal frequency
> > but no maximum, some have a maximum frequency but no minimal, and I
> > guess most of them deviates by how much exactly they can take (and
> > possibly can take more easily a higher frequency, but are less
> > tolerant if you take a frequency lower than the nominal.
> >
> > And we cannot remove that check entirely, since some bridges will
> > report out of range frequencies for higher modes that we know we
> > cannot reach.
> 
> I believe this should be handled by the bridge driver in the check
> callback?

This doesn't really have anything to do with the bridge itself, it's a
limitation on the encoder. For all we know, the bridge might be able
to operate at the higher resolutions without any issues if the encoder
was able to.

> The callback I'm changing is attached to the connector, which I
> think doesn't get used if you have a bridge instead.  And this only
> checks the pre-registered display modes, such as those specified in
> simple-panel or EDID.

Geeee, I forgot to send that one (and thought I did)... I'll send that
patch next week, but basically, I was creating a mode_valid hook at
the encoder level, and moving the RGB mode_valid hook from the
connector to the encoder (since it really is an encoder limitation).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161209/18a5ba71/attachment.sig>
