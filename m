From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Jan 2013 09:39:33 +0100
Subject: [PATCH RESEND 0/2] CFA10036: Switch to SPI Bitbanging
Message-ID: <1359103175-26304-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a patchset that moves the spi bus we use to bitbanging. This is needed
because the DAC found on this bus is actually using a 12 bits wordlength, while
the imx28 spi controler can only handle 4, 8 or 16 bits per words.

Thanks,
Maxime

Maxime Ripard (2):
  spi: spi-gpio: Add checks for the dt properties
  ARM: dts: cfa10049: Change the SPI3 bus to spi-gpio

 arch/arm/boot/dts/imx28-cfa10049.dts |   78 ++++++++++++++++++----------------
 drivers/spi/spi-gpio.c               |   23 ++++++++--
 2 files changed, 62 insertions(+), 39 deletions(-)

-- 
1.7.10.4
