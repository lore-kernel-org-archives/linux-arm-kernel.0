From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Aug 2016 18:41:56 +0200
Subject: [PATCH] drm/sun4i: Clear encoder->bridge if a bridge is not found
In-Reply-To: <CAGb2v67hiYhjQNXLZUz7ZT2214AAYsFwQkg42qKEFv-7kShsQQ@mail.gmail.com>
References: <20160830122223.21377-1-wens@csie.org>
 <20160830125622.GF18605@lukather>
 <CAGb2v64JC5+uzsvLjZVi_Xi8q=U+_Bokqnu33w3oQ-2h2DLnKg@mail.gmail.com>
 <CAGb2v67hiYhjQNXLZUz7ZT2214AAYsFwQkg42qKEFv-7kShsQQ@mail.gmail.com>
Message-ID: <20160831164156.GL14379@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 07:09:23PM +0800, Chen-Yu Tsai wrote:
> >>>       sun4i_tcon_channel_disable(tcon, 0);
> >>>
> >>> -     if (!IS_ERR(encoder->bridge))
> >>> -             drm_bridge_disable(encoder->bridge);
> >>> +     drm_bridge_disable(encoder->bridge);
> >>
> >> I'd rather keep those changes, it makes it obvious that it's something
> >> optionnal, that can be set to NULL.
> >
> > OK.
> 
> What about having a comment instead? Saves an extra branch condition,
> while still showing that it's optional.

I'm not sure we have to worry about an extra branch condition, but
yeah, that works for me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/05fc9ca6/attachment.sig>
