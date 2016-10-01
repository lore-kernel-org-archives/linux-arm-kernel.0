From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 1 Oct 2016 15:00:56 +0530
Subject: [PATCH v2] drm: tilcdc: add a da850-specific compatible string
In-Reply-To: <1475243564-15765-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475243564-15765-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <12dad169-de04-ce7d-0422-94c57074c839@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2016 07:22 PM, Bartosz Golaszewski wrote:
> Due to some potential tweaks for the da850 LCDC (for example: the
> required memory bandwith settings) we need a separate compatible
> for the IP present on the da850 boards.
> 
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> v1 -> v2:
> - added the new compatible to the bindings documentation
> 
>  Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt | 4 ++--
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c                         | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> index a83abd7..33b6e8a 100644
> --- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> +++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
> @@ -1,7 +1,7 @@
>  Device-Tree bindings for tilcdc DRM driver
>  
>  Required properties:
> - - compatible: value should be "ti,am33xx-tilcdc".
> + - compatible: value should be "ti,am33xx-tilcdc" or "ti,da850-tilcdc".

This documentation does not help much :( It should be on the lines of:

compatible: value should be "ti,am33xx-tilcdc" for AM335x based boards
	    value should be "ti,da850-tilcdc" for DA850/AM18x/OMAP-L138
	    based boards

There are many existing examples of the way compatible strings are
documented. You can take a look at them too. Also, since you are
introducing a new device-tree compatible, please keep the devicetree
list and maintainers in CC too. I don't think it shows up in
get_maintainer.pl, so you will have to remember to do it.

Thanks,
Sekhar
