From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:21:36 +0800
Subject: [PATCH 00/13] media: atmel-isi: extract the hw releated functions
 into structure
Message-ID: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series refactor the atmel-isi drvier. In the meantime, extract all
the hardware related functions, and made it as function table. Also add
some hardware data.

All those hardware functions, datas are defined with the compatible
string.

In this way, it is easy to add another compatible string for new
hardware support.


Josh Wu (13):
  atmel-isi: use try_or_set_fmt() for both set_fmt() and try_fmt()
  atmel-isi: move the is_support() close to try/set format function
  atmel-isi: add isi_hw_initialize() function to handle hw setup
  atmel-isi: move the cfg1 initialize to isi_hw_initialize()
  atmel-isi: add a function: isi_hw_wait_status() to check ISI_SR status
  atmel-isi: check ISI_SR's flags by polling instead of interrupt
  atmel-isi: move hw code into isi_hw_initialize()
  atmel-isi: remove the function set_dma_ctrl() as it just use once
  atmel-isi: add a function start_isi()
  atmel-isi: reuse start_dma() function in isi interrupt handler
  atmel-isi: add hw_uninitialize() in stop_streaming()
  atmel-isi: use union for the fbd (frame buffer descriptor)
  atmel-isi: use an hw_data structure according compatible string

 drivers/media/platform/soc_camera/atmel-isi.c | 529 ++++++++++++++------------
 1 file changed, 277 insertions(+), 252 deletions(-)

-- 
1.9.1
