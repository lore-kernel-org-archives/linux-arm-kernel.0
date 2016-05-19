From: vigneshr@ti.com (Vignesh R)
Date: Thu, 19 May 2016 14:33:59 +0530
Subject: [RFC PATCH 0/2] AM335x-ICE: Add support for rotary-encoder
Message-ID: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds support for rotary-encoder on AM335x-ICE that is
connected to TI PCA9536 I2C GPIO expander.

The rotary encoder is different from the incremental encoders in the
sense that GPIO line status directly reflect the position(number)
pointed by the dial of the encoder. So, there is no need to count steps
or know the direction of rotation. Patch 1/2 adds DT property
"rotary-encoder,absolute-encoder" to support this encoder. Since, such
encoders do not actually require IRQ lines (as the encoder state can
always be known by reading GPIO lines at that moment), support for
polling based input is added.
The second patch adds DT entry for the rotary-encoder present on
AM335x ICE board.

Tested on AM335x ICE board that has above described rotary-encoder
without IRQs (polling mode).
I don't have hardware with incremental encoder or encoder with IRQ,
please give it a spin on incremental encoders for sanity.

Vignesh R (2):
  Input: rotary-encoder- Add support for absolute encoder
  ARM: dts: am335x-icev2: Add rotary-encoder node

 .../devicetree/bindings/input/rotary-encoder.txt   |   4 +
 Documentation/input/rotary-encoder.txt             |   9 ++
 arch/arm/boot/dts/am335x-icev2.dts                 |  11 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/rotary_encoder.c                | 165 ++++++++++++++++-----
 5 files changed, 166 insertions(+), 34 deletions(-)

-- 
2.8.2
