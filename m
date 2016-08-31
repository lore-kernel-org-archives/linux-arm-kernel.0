From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Aug 2016 18:43:00 +0200
Subject: [PATCH] drm/sun4i: Clear encoder->bridge if a bridge is not found
In-Reply-To: <20160831162708.GD20761@phenom.ffwll.local>
References: <20160830122223.21377-1-wens@csie.org>
 <20160830125622.GF18605@lukather>
 <CAGb2v64JC5+uzsvLjZVi_Xi8q=U+_Bokqnu33w3oQ-2h2DLnKg@mail.gmail.com>
 <20160831154002.GC14379@lukather>
 <20160831162708.GD20761@phenom.ffwll.local>
Message-ID: <20160831164300.GA15402@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 06:27:08PM +0200, Daniel Vetter wrote:
> > > >> +     if (IS_ERR(encoder->bridge))
> > > >> +             encoder->bridge = NULL;
> > > >> +
> > > >
> > > > And that could be the else condition of the if statement below.
> > > 
> > > That would be a bit confusing, changing it after calling drm_encoder_init.
> > > The code says it ok to do though.
> > 
> > The magic really happens only after the encoder has been attached to
> > something, so it's really safe.
> 
> s/attached/registered using drm_dev_register(). Which should
> happen _way_ later for all drivers which have gotten rid of their ->load
> callback and implemented the recommend driver load sequence.

My bad, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/39904c8d/attachment.sig>
