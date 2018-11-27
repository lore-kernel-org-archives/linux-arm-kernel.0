From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:58:33 +0100
Subject: [PATCH v2 25/43] drm/sun4i: frontend: Apply format sub-sampling
 to CH1 dimensions
In-Reply-To: <20181123092515.2511-26-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-26-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085833.b6jhe5npgsvl2g5f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:57AM +0100, Paul Kocialkowski wrote:
> The frontend comes with two "channels", that can be configured
> independently. When used in YUV mode, the first channel (CH0) represents
> the luminance component while the second channel (CH1) represents the
> chrominance. In RGB mode, both have to be configured the same way.
> 
> Use variables (with the YUV terminology) for each channel's
> dimensions, calculating the chroma dimensions from the luma dimensions
> and the sub-sampling factors from the format description.
> 
> Since the configured size only has pixel precision, the fractional
> fixed-point part of the source size is dropped for both components to
> ensure that the scaling factors are accurate.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/613b5f43/attachment.sig>
