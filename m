From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 19 Oct 2015 17:01:58 -0700
Subject: [PATCH] fpga: zynq-fpga: Replacing BIT with BIN format
Message-ID: <1445299319-14921-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

as discussed, here a patch that removes the byteswapping
code, leaving format conversion to userland.

However I added a crude check to bail out early if the sync word
isn't found in the firmware file, to avoid kicking the hardware
unneccesary.

This change requires people to use the appropriate Xilinx tools to
generate the (byteswapped) .bin files.

Cheers,

    Moritz

Moritz Fischer (1):
  fpga: zynq-fpga: Change fw format to handle bin instead of bit.

 drivers/fpga/zynq-fpga.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

-- 
2.6.1
