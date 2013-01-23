From: koen@dominion.thruhere.net (Koen Kooi)
Date: Wed, 23 Jan 2013 08:43:41 +0100
Subject: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
In-Reply-To: <1358894185-21617-2-git-send-email-robdclark@gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
Message-ID: <9D3F79D4-17D5-4DEA-BA4C-1C200B4187E2@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 22 jan. 2013, om 23:36 heeft Rob Clark <robdclark@gmail.com> het volgende geschreven:

> A simple DRM/KMS driver for the TI LCD Controller found in various
> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the
> CMA helpers.  Currently only the TFP410 DVI encoder is supported
> (tested with beaglebone + DVI cape).  There are also various LCD
> displays, for which support can be added (as I get hw to test on),
> and an external i2c HDMI encoder found on some boards.
> 
> The display controller supports a single CRTC.  And the encoder+
> connector are split out into sub-devices.  Depending on which LCD
> or external encoder is actually present, the appropriate output
> module(s) will be loaded.
> 
> v1: original
> v2: fix fb refcnting and few other cleanups
> v3: get +/- vsync/hsync from timings rather than panel-info, add
>    option DT max-bandwidth field so driver doesn't attempt to
>    pick a display mode with too high memory bandwidth, and other
>    small cleanups
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Tested on a beaglebone and beaglebone-black:

Tested-by: Koen Kooi <koen@dominion.thruhere.net>
