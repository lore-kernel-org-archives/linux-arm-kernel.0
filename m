From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Mar 2018 16:48:56 +0200
Subject: [PATCH 09/10] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
In-Reply-To: <1522140098.1110.40.camel@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-10-paul.kocialkowski@bootlin.com>
 <20180323104856.qo7w376xr3gcznmm@flea>
 <1522140098.1110.40.camel@bootlin.com>
Message-ID: <20180327144856.rb757m35zyscefnn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 10:41:38AM +0200, Paul Kocialkowski wrote:
> > > +int drm_sun4i_gem_create_tiled(struct drm_device *dev, void *data,
> > > +			       struct drm_file *file_priv);
> > 
> > Do you need it to be non-static, and part of the header as well?
> 
> Here as well, I just find that it looks more readable that way, below
> the drm driver structure definition instead of above it.

But it also creates a global symbol for no particular reason, while
we're doing the function-first-structure-later pattern pretty much
everywhere else in the kernel.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/c5fa1248/attachment.sig>
