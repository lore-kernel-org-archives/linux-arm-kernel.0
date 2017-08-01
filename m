From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Aug 2017 01:29:32 +0300
Subject: [PATCH v2 0/4] dw-hdmi CEC support
In-Reply-To: <20170731142906.GX31807@n2100.armlinux.org.uk>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
Message-ID: <17264852.3R3UM7X4I0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thank you for the patches.

On Monday 31 Jul 2017 15:29:06 Russell King - ARM Linux wrote:
> Hi,
> 
> This series adds dw-hdmi CEC support.  This is done in four stages:
> 
> 1. Add cec-notifier support
> 2. Fix up the clkdis register support, as this register contains a
>    clock disable bit for the CEC module.
> 3. Add the driver.
> 4. Remove definitions that are not required from dw-hdmi.h
> 
> The CEC driver has been updated to use the register accessors in the
> main driver - it would be nice if it was possible to use the regmap
> support directly, but there's some knowledge private to the main
> driver that's required to correctly access the registers.  (I don't
> understand why the register stride isn't part of regmap.)
> 
>  drivers/gpu/drm/bridge/synopsys/Kconfig       |  10 +
>  drivers/gpu/drm/bridge/synopsys/Makefile      |   1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 326 +++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.h |  19 ++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  93 +++++++-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  46 +---
>  6 files changed, 437 insertions(+), 58 deletions(-)
> 
> v2 - fix selection of CEC_NOTIFIER in Kconfig

For the whole series,

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

on R-Car H3.

The DWC HDMI controller in this SoC supports CEC, but I have no CEC-enabled 
sink, so tests were limited to regression checks.

-- 
Regards,

Laurent Pinchart
