From: david@lechnology.com (David Lechner)
Date: Sat,  6 Jan 2018 21:19:49 -0600
Subject: [PATCH 0/3] ARM: da8xx: remove con_id from USB clocks
Message-ID: <1515295192-17883-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes unnecessary con_ids on da8xx USB clocks in preparation
of adding device tree support for clocks on this platform.

Note: this is a resend  of "USB: musb: da8xx: remove clock con_id" and
"USB: ohci: da8xx: remove clk con_id". I sent them before I realized that
things break if you don't also remove the con_id when registering the
clkdev. :-/

David Lechner (3):
  USB: musb: da8xx: remove clock con_id
  USB: ohci: da8xx: remove clk con_id
  ARM: da8xx: remove con_id from USB clocks

 arch/arm/mach-davinci/da830.c | 4 ++--
 arch/arm/mach-davinci/da850.c | 4 ++--
 drivers/usb/host/ohci-da8xx.c | 2 +-
 drivers/usb/musb/da8xx.c      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.7.4
