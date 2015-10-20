From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 20 Oct 2015 10:19:55 -0700
Subject: [PATCHv2] fpga: zynq-fpga: Replacing BIT with BIN format
Message-ID: <1445361596-12024-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I dropped the check of the firmware file entirely and let the hardware
figure out if there's no sync word in there.
As Mike suggested I tested with streaming random garbage files to the
device and the hardware dealt with it just fine.

Cheers,

    Moritz

Moritz Fischer (1):
  fpga: zynq-fpga: Change fw format to handle bin instead of bit.

 drivers/fpga/zynq-fpga.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

-- 
2.6.1
