From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 3 Aug 2018 09:30:05 +0200
Subject: [RESEND PATCH v5 0/3] drm/atmel-hlcdc: bus-width override support
In-Reply-To: <20180803072308.14962-1-peda@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
Message-ID: <20180803093005.60eec28e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  3 Aug 2018 09:23:05 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> This is perhaps not a true resend in that these three patches were
> originally in a larger series [1], and the series have been rebased
> to v4.18-rc6. However, I did ask that these three patches should be
> considered separately. The other patches in the original series have
> been adopted and reworked by Russell King [2].

Oops, completely forgot to apply those 3 patches. If there's no
objection I'll queue them to drm-misc-next.

Regards,

Boris

> 
> The background for these patches is that our PCB interface between
> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
> this has to be described somewhere, or the atmel-hlcdc driver have no
> chance of selecting the correct output mode. Since we have similar
> problems with a tda19988 HDMI encoder I added patches to override
> the atmel-hlcdc output format via DT properties compatible with the
> media video-interface binding and things start to play together.
> I of course need my old patches or the new ones from Russell to
> actually use the HDMI encoder with the SAMA5D3, but that is not
> directly related to this (shortened) series.
> 
> Cheers,
> Peter
> 
> [1] https://lkml.org/lkml/2018/5/23/273
> [2] https://www.spinics.net/lists/arm-kernel/msg669238.html
> 
> Peter Rosin (3):
>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>   dt-bindings: display: atmel: optional video-interface of endpoints
>   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
> 
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++
>  .../bindings/display/bridge/lvds-transmitter.txt   |  8 ++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++++++-------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 67 ++++++++++++++++++---
>  5 files changed, 144 insertions(+), 28 deletions(-)
> 
