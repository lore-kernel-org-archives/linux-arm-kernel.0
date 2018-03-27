From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Mar 2018 16:47:48 +0200
Subject: [PATCH 06/10] drm/sun4i: Move and extend format-related helpers
 and tables
In-Reply-To: <1522139264.1110.28.camel@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-7-paul.kocialkowski@bootlin.com>
 <20180323101338.z422gpxcsdre5hgj@flea>
 <1522139264.1110.28.camel@bootlin.com>
Message-ID: <20180327144748.xxpn4s3wjpt6hw4j@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 10:27:44AM +0200, Paul Kocialkowski wrote:
> > > +bool sun4i_format_is_rgb(uint32_t format);
> > > +bool sun4i_format_is_yuv(uint32_t format);
> > > +bool sun4i_format_is_yuv411(uint32_t format);
> > > +bool sun4i_format_is_yuv420(uint32_t format);
> > > +bool sun4i_format_is_yuv422(uint32_t format);
> > > +bool sun4i_format_is_yuv444(uint32_t format);
> > > +bool sun4i_format_is_packed(uint32_t format);
> > > +bool sun4i_format_is_semiplanar(uint32_t format);
> > > +bool sun4i_format_is_planar(uint32_t format);
> > > +bool sun4i_format_supports_tiling(uint32_t format);
> > 
> > If we're going to add so many of them, then we should really consider
> > to move them to drm_fourcc.c instead. Every one has some variation of
> > some of these functions, we don't really need to duplicate it all the
> > time.
> 
> Should I try to get that through in this patchset and have sun4i-drm
> be their first user? Also, does introducing such a change require
> identifying duplicates of these functions in each DRM driver's
> codebase?

I guess converting at least one of them would prove how usable it
would be to other drivers, but I won't ask you to convert all of them
as part of this serie :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/4fc84eb8/attachment.sig>
