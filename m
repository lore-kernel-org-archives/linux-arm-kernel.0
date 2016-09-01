From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 1 Sep 2016 10:19:19 +0300
Subject: [PATCH v3 3/8] drm/tilcdc: Add blue-and-red-crossed devicetree
 property
In-Reply-To: <1fc6a6bb5b56b9bac845502b0724d7a07f0675fb.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
 <1fc6a6bb5b56b9bac845502b0724d7a07f0675fb.1472634657.git.jsarha@ti.com>
Message-ID: <64641724-24d8-47ff-92ad-7f05f86669da@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/08/16 16:14, Jyri Sarha wrote:
> Add "blue-and-red-wiring"-device tree property and update devicetree
> binding document. The red and blue components are reversed between 24
> and 16 bit modes on am335x LCDC output pins. To get 24 RGB format the
> red and blue wires has to be crossed and this in turn causes 16 colors
> output to be in BGR format. With straight wiring the 16 color is RGB
> and 24 bit is BGR. The new property describes whether the red and blue
> wires are crossed or not. If the property is not present or its value
> is not recognized the legacy mode is assumed. The legacy configuration
> supports RGB565, RGB888 and XRGB8888 formats. However, depending on
> wiring, the red and blue colors are swapped in either 16 or 24-bit
> color modes.
> 
> For more details see section 3.1.1 in AM335x Silicon Errata:
> http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../devicetree/bindings/display/tilcdc/tilcdc.txt  | 22 ++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c                | 42 ++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h                |  4 +++
>  drivers/gpu/drm/tilcdc/tilcdc_plane.c              |  9 ++---
>  4 files changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> index 6efa4c5..5b7b5f8 100644
> --- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> +++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> @@ -17,6 +17,18 @@ Optional properties:
>     the lcd controller.
>   - max-pixelclock: The maximum pixel clock that can be supported
>     by the lcd controller in KHz.
> + - blue-and-red-wiring: Recognized values "default", "straight" or
> +   "crossed". This property deals with the LCDC revision 2 (found on
> +   AM335x) color errata [1].
> +     - "default" and "straight" indicates normal wiring that supports

I didn't mean to add two values for this =). Just use one, there's no
benefit in supporting multiple values meaning the same thing.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/100b5bb2/attachment.sig>
