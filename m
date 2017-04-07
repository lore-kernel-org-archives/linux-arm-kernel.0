From: romain.perier@collabora.com (Romain Perier)
Date: Fri,  7 Apr 2017 16:19:03 +0200
Subject: [PATCH 0/2] drm: dw-hdmi: various improvements
Message-ID: <20170407141905.14147-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches split the stream handling functions in two parts. It
introduces new callbacks that are specific to each variant, one for I2S
and one for AHB.

Then, as requested by the datasheet for the I2S variant, it adds support
for gating the audio sampler clock when the audio stream is enabled and
disabled.

This patches series is the continuity of the following discussion:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/493550.html

Romain Perier (2):
  drm: dw-hdmi: add specific I2S and AHB functions for stream handling
  drm: dw-hdmi: Gate audio clock from the I2S enablement callbacks

 drivers/gpu/drm/bridge/dw-hdmi.c | 45 +++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

-- 
2.9.3
