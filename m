From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 17:09:36 +0100
Subject: [PATCH 0/9] dw-hdmi audio support
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <20150808160936.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following on from the previous sub-series, this sub-series adds audio
support to dw-hdmi.

The two different variants are now in this patch: AHB audio support
found on iMX6 platforms, and I2S support found on Rockchip patches.
Thanks to Yakir Yang for contributing the I2S support.

I suspect that there is still some discussion to be had on this
series, though I would like to see it moving forward so that we can
get something merged.

 drivers/gpu/drm/bridge/Kconfig             |  20 +
 drivers/gpu/drm/bridge/Makefile            |   2 +
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 635 +++++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi-audio.h     |  14 +
 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c | 398 ++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi.c           | 202 ++++-----
 drivers/gpu/drm/bridge/dw_hdmi.h           |   6 +
 7 files changed, 1155 insertions(+), 122 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
