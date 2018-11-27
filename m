From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:02:02 +0100
Subject: [PATCH v2 29/43] drm/sun4i: Make pitch even for GEM dumb alloc
 as per hardware constraint
In-Reply-To: <20181123092515.2511-30-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-30-paul.kocialkowski@bootlin.com>
Message-ID: <20181127090202.ksywle3ttojjbyms@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:25:01AM +0100, Paul Kocialkowski wrote:
> Our hardware requires the pitch to be an even number when using YUV
> formats with the frontend. Implement a driver-specific callback for GEM
> dumb allocation that sets the pitch accordingly.
> 
> Since only the bpp is passed (and not the format), we cannot really
> distinguish if this alignment is really required. Since it doesn't hurt
> to align the pitch anyway, always do it.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/e820a3cd/attachment.sig>
