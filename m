From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat,  1 Sep 2018 22:12:12 +0530
Subject: [PATCH 0/3] Add slave DMA support for Actios Semi S900 SoC
Message-ID: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds slave DMA support for Actions Semi S900 SoC of the
Owl family. As a consumer, enable TX DMA support for UART peripheral
in S900. The UART driver still supports interrupt mode if there is no
DMA property specified in DT.

The dts patch depends on the previous DMA patches which is not yet
merged.

Thanks,
Mani

Manivannan Sadhasivam (3):
  arm64: dts: actions: s900: Enable Tx DMA for UART5
  dmaengine: Add Slave and Cyclic mode support for Actions Semi Owl S900
    SoC
  tty: serial: Add Tx DMA support for UART in Actions Semi Owl SoCs

 arch/arm64/boot/dts/actions/s900.dtsi |   2 +
 drivers/dma/owl-dma.c                 | 273 +++++++++++++++++++++++++-
 drivers/tty/serial/owl-uart.c         | 172 +++++++++++++++-
 3 files changed, 439 insertions(+), 8 deletions(-)

-- 
2.17.1
