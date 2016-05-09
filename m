From: absahu@codeaurora.org (Abhishek Sahu)
Date: Mon,  9 May 2016 18:14:29 +0530
Subject: [PATCH 0/2] i2c: qup: Fixed the DMA transfer errors
Message-ID: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches contain the I2C QUP (Qualcomm Universal Peripheral) DMA
related fixes. The first patch cleared the error bits in ISR, which
resolves the kernel hang for I2C bus errors and DMA transfer. The
second patch fixed the DMA segments length, which resolves the issue
for I2C transfer failure over 255 bytes.

Abhishek Sahu (2):
  drivers: i2c: qup: Cleared the error bits in ISR
  drivers: i2c: qup: Fixed the DMA segments length

 drivers/i2c/busses/i2c-qup.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
