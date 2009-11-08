From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sun, 08 Nov 2009 19:52:17 +0100
Subject: [REPOST PATCH  0/3] MX21 USB Host Support
Message-ID: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the USB host controller in the
Freescale i.MX21 SoC.

Only host mode (not function or OTG mode) is currently supported (the OTG
port may be used in host only mode).

Power management is not yet implemented (as it has not yet been implemented
for MXC).

The driver has been tested with usbtest suite and has run for several days
with other simultaneous USB activity (webcam + mass storage).

The driver part is the same as that posted in June just rebased to 2.6.32-rc5

The changes to the platform resource part are:
   * Clock patch dropped as now merged
   * Let compiler count array indices in platform resources
   * Use DMA_BIT_MASK
