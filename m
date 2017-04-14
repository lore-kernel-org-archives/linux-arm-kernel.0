From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 14 Apr 2017 10:31:11 +0200
Subject: [PATCH v2 0/2] drm: dw-hdmi: various improvements
Message-ID: <20170414083113.4255-1-romain.perier@collabora.com>
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

Changes in v2:
- Add NULL check in dw_hdmi_audio_enable/dw_hdmi_audio_disable
- Don't define dw_hdmi_i2s_audio_disable in PATCH 1/2
- Rebased onto drm-misc-next

Romain Perier (2):
  drm: dw-hdmi: add specific I2S and AHB functions for stream handling
  drm: dw-hdmi: gate audio clock from the I2S enablement callbacks

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 46 +++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

-- 
2.9.3
