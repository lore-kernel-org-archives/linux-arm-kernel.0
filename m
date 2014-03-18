From: mr.nuke.me@gmail.com (Alexandru Gagniuc)
Date: Tue, 18 Mar 2014 15:04:02 -0700 (PDT)
Subject: [PATCH 0/2] v1: ARM: sun4i: spi: Allow transfers larger than FIFO size
Message-ID: <4636665.0CNduaaJi4@nukelap.gtech>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are designed to apply on top of sunxi-next. They depend on 
Maxime Ripard's SPI patches for Allwinner A10 (sun4i).

I've watched the bus with a logic analyzer to make sure thing are sane, but 
I'm only able to go up to 10MHz on my LA. Unfortunately, the SPI chip I was 
using as a test device decided to die mid-way, so I was unable to test how 
well full-duplex communication works on these large transfers

Alexandru Gagniuc (2):
  ARM: sun4i: spi: Allow Rx transfers larger than FIFO size
  ARM: sun4i: spi: Allow Tx transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 56 
+++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
1.8.5.3
