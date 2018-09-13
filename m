From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Sep 2018 14:31:45 +0200
Subject: [PATCH v3 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
In-Reply-To: <1535451894-2518-1-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
Message-ID: <11916444.D1tlAhbW8U@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. August 2018, 12:24:43 CEST schrieb Damian Kos:
> Hello!
> 
> This is the series of patches that will add support for the Cadence's DPI/DP
> bridge. Please note that this is a preliminary version of the driver and there
> will be more patches in the future with updates, fixes and improvements.
> Please keep that in mind when looking at FIXME/TODO/XXX comments.
> 
> Initially, MHDP driver was developed as a DRM bridge driver and was planed to
> be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
> a driver for Cadence's DP controller developed by RockChip, but that driver
> uses the different DRM framework and looks like a part of a bigger system.
> Both controllers (including firmware) are quite different internally
> (MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
> etc.) but they have similar register map, except for Framer/Streamer (which is
> noticeably different), so they appear similar.
> 
> The following patches contain:
> - Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
>   modifying it a bit (mostly new prefixes for functions and data types) so it
>   can be used by two, higher level, drivers.
> - Modifying existing RockChip's DP driver to use the common code after changes
>   made to it (use the new cdns_mhdp_device structure and new function names).
> - Modifying DRM helpers a bit. Some are required for new driver, some are
>   updates from DP 1.2 to 1.3 or 1.4.
> - Adding documentation for device tree bindings.
> - Adding preliminary Cadence DPI/DP bridge driver.
> 
> Some of the things that will be added later on include (but are not limited
> to):
> - Support for Cadence SD0801 PHY (PHY's driver should be on the way by now)
> - MST support
> - DSC support
> - FEC support
> - HDCP support

with te Kconfig issue in patch5 fixed, this series tested on
rk3288 (analogix-dp) and rk3399 (analogix-dp + cadence-dp)
Everything seems to work that worked before.

Tested-by: Heiko Stuebner <heiko@sntech.de>
