From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 17:02:51 +0100
Subject: [PATCH 00/12] dw-hdmi development
Message-ID: <20150808160251.GM7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sub-series is a mixture of development:

* Removing the incorrect pixel repetition configuration code
* Preventing pixel-doubled modes from being used
* Adding interlaced video support
* Implementing the sink_is_hdmi/sink_has_audio flags I suggested a few
  months ago
* Only enabling audio support if the sink indicates it has audio
* Avoiding double-enabling the HDMI interface
* Fixing the mis-leading name of "dw_hdmi_phy_enable_power"
* Adding connector mode forcing (important if your monitor bounces
  RXSENSE and HPD signals while in low-power mode.)
* Improving the HDMI enable/disabling on sink status

For review (and testing if people feel like it).  Acks/tested-bys etc
welcome.  It applies on top of my drm-dwhdmi-devel branch, which is
waiting for David Airlie to pull (see pull request on dri-devel, 15th
July.)

 drivers/gpu/drm/bridge/dw_hdmi.c | 275 ++++++++++++++++++++++++++++++---------
 drivers/gpu/ipu-v3/ipu-dc.c      |  18 ++-
 drivers/gpu/ipu-v3/ipu-di.c      | 129 +++++++++---------
 3 files changed, 291 insertions(+), 131 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
