From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Aug 2014 15:06:16 +0100
Subject: [PATCH v3] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140708114057.5ef3cfd0@armhf>
References: <20140708114057.5ef3cfd0@armhf>
Message-ID: <20140816140616.GN28623@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 11:40:57AM +0200, Jean-Francois Moine wrote:

>  .../devicetree/bindings/drm/i2c/tda998x.txt        |  13 ++
>  drivers/gpu/drm/i2c/Makefile                       |   2 +-
>  drivers/gpu/drm/i2c/tda998x_codec.c                | 247 +++++++++++++++++++++
>  drivers/gpu/drm/i2c/tda998x_drv.c                  |  74 ++++--
>  drivers/gpu/drm/i2c/tda998x_drv.h                  |  32 +++
>  include/drm/i2c/tda998x.h                          |   1 +

I'd expect to see the ASoC parts of this appear under sound/soc (even if
just a library that the DRM driver links against rather than as a MFD).
This should help avoid cross tree issues and surprises when people do
API changes.

> +  - audio-ports: one or two values corresponding to entries in
> +	the audio-port-names property.

What are these values?

> +  - audio-port-names: must contain "i2s", "spdif" entries
> +	matching entries in the audio-ports property.

So it's mandatory that both I2S and S/PDIF be specified?

The code looks broadly sensible in so far as it
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/ba04e7c1/attachment.sig>
