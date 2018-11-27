From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:31:23 +0100
Subject: [PATCH v2 02/43] drm/sun4i: frontend: Replace ARGB with XRGB as
 supported format
In-Reply-To: <20181123092515.2511-3-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-3-paul.kocialkowski@bootlin.com>
Message-ID: <20181127083123.ok6eftf2nd4arqe5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:34AM +0100, Paul Kocialkowski wrote:
> The frontend documentation (for the A33) mentions that ARGB is supported
> as output, but with the alpha component always set to 0xff. In practice,
> this means that the alpha component cannot be preserved when going
> through the frontend. Since the information is lost, ARGB is not
> properly supported.
> 
> As a result, expose the matching format supported by the frontend (both
> for input and output) as XRGB instead of ARGB.
> 
> Since ARGB was the selected format for connecting the frontend to the
> backend, change it to XRGB to reflect this as well.
> 
> The A31 and A80 SoCs apparently have a bit to enable proper alpha,
> but this is not supported at this point (see the comment already in the
> code).
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/4c67ae65/attachment.sig>
