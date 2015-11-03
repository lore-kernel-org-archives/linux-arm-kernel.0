From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 3 Nov 2015 13:45:07 +0800
Subject: [PATCH v2 0/5] media: atmel-isi: enable preview path to output RGB565
 format
Message-ID: <1446529512-19109-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series will enable preview path support in atmel-isi. Which can
make atmel-isi convert the YUV format (from sensor) to RGB565 format.

Changes in v2:
- remove the duplicated variable: cfg2_yuv_swap.
- correct the comment style
- According to Guennadi's suggestion, remove the is_output_rgb() function
  which only used once. Also move the code into the for loop.

Josh Wu (5):
  media: atmel-isi: correct yuv swap according to different sensor
    outputs
  media: atmel-isi: prepare for the support of preview path
  media: atmel-isi: add code to setup correct resolution for preview
    path
  media: atmel-isi: setup YCC_SWAP correctly when using preview path
  media: atmel-isi: support RGB565 output when sensor output YUV formats

 drivers/media/platform/soc_camera/atmel-isi.c | 162 +++++++++++++++++++-------
 drivers/media/platform/soc_camera/atmel-isi.h |  10 ++
 2 files changed, 132 insertions(+), 40 deletions(-)

-- 
1.9.1
