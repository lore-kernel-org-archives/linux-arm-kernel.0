From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Mar 2016 14:06:55 +0100
Subject: [PATCH 0/8] drm: atmel-hlcdc: various fixes/improvements
In-Reply-To: <1452075569-8545-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1452075569-8545-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56E95A6F.5070003@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/01/2016 11:19, Boris Brezillon a ?crit :
> Hello,
> 
> This series is a collection of fixes and improvements for the
> atmel-hlcdc driver.
> 
> The main feature added here is the support for external RGB -> XXX
> bridges (patch 6 and 7).
> 
> The first patch is a fix preventing a potential memory leak.
> Patch 2 is adding support for asynchronous mode setting, which was
> supported before the migration to atomic mode setting.
> 
> Patch 3 is just a minor fix to expose the real encoder and connector
> types (we are currently exposing an LVDS encoder/connector, which is
> wrong since the display controller output the pixel stream in raw
> RGB).
> 
> Patch 4 is removing useless fields and functions which were left
> when moving to atomic modesetting.
> 
> And patch 8 is just a cosmetic patch moving the mode checking code
> from ->atomic_check() to ->mode_fixup().

To give more weight to this series, you can also add my:

Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,


> Boris Brezillon (8):
>   drm: atmel-hlcdc: add a ->cleanup_fb() operation
>   drm: atmel-hlcdc: support asynchronous atomic commit operations
>   drm: atmel-hlcdc: fix connector and encoder types
>   drm: atmel-hlcdc: remove leftovers from atomic mode setting migration
>   drm: atmel-hlcdc: support extended timing ranges on sama5d4 and
>     sama5d2
>   drm: atmel-hlcdc: move output mode selection in CRTC implementation
>   drm: atmel-hlcdc: rework the output code to support drm bridges
>   drm: atmel-hlcdc: check display mode validity in crtc->mode_fixup()
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 148 +++++++++++++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     | 123 ++++++++++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  16 ++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 249 ++++++++++-------------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  |  22 +-
>  5 files changed, 400 insertions(+), 158 deletions(-)
> 


-- 
Nicolas Ferre
