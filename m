From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  2 Aug 2013 10:33:28 +0200
Subject: [PATCH v3 0/2] usb: gadget: at91_udc: add usb_clk for transition to
 common clk framework
Message-ID: <1375432408-28371-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series prepare the at91 SoCs transition to common clk framework.
This is done by adding a new clock (called usb clock or uclk) to at91_udc
driver. This clock will be used to configure the usb port clock rate.

Best Regards,

Boris

Changes since v2:
- split the patch in 2 parts:
    * add missing clk_put for existing clk (fclk and uclk)
    * add usb clock (uclk) support

Changes since v1:
- use IS_ENABLED(CONFIG_COMMON_CLK) to isolate new at91 clk support  

Boris BREZILLON (2):
  usb: gadget: at91_udc: add missing clk_put on fclk and iclk
  usb: gadget: at91_udc: add usb_clk for transition to common clk
    framework

 drivers/usb/gadget/at91_udc.c |   21 +++++++++++++++++++--
 drivers/usb/gadget/at91_udc.h |    2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.7.9.5
