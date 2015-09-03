From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu,  3 Sep 2015 18:59:48 +0100
Subject: [PATCH v5 0/6]  [media] c8sectpfe: Various fixups
Message-ID: <1441303194-28211-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

This series includes a couple of fixes for the c8sectpfe Linux dvb driver.

The only difference versus v5 is on RobH advice we are back to "reset-gpios"
for the binding.

One was caused by omitting a patch from the original c8sectpfe series which
defined the ssc2 and ssc3 dt nodes, which was then used by the later DT patch.
This patch is included, along with the original patch which you reverted.

Also Valentin Rothberg spotted LIBELF32 Kconfig symbol I was selecting in the
Kconfig, this isn't required upstream and is left over legacy so I've removed
it.

Also included are some fixups spotted by Lee Jones.

Changes since v4:
 - Change back (again) to "reset-gpios"

Changes since v3:
 - Collect up more acks
 - Change binding to "reset-gpio"
 - highlight dtb incompatability in commit message

Changes since v2:
 - Add some "\n" and other formatting fixes
 - 'Suggested by' should be in chronological order
 - Simplify load_slim_core_fw loop

Changes since v1:
 - Various formating patches to DT node
 - Update to reset-gpios
 - Use GPIO_ACTIVE_HIGH, GIC_SPI and IRQ_TYPE_NONE defines

kind regards,

Peter.

Peter Griffin (6):
  ARM: DT: STi: stihxxx-b2120: Add pulse-width properties to ssc2 & ssc3
  ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB DT node.
  [media] c8sectpfe: Remove select on undefined LIBELF_32
  [media] c8sectpfe: Update binding to reset-gpios
  [media] c8sectpfe: Update DT binding doc with some minor fixes
  [media] c8sectpfe: Simplify for loop in load_slim_core_fw

 .../bindings/media/stih407-c8sectpfe.txt           | 20 +++++-----
 arch/arm/boot/dts/stihxxx-b2120.dtsi               | 45 +++++++++++++++++++++-
 drivers/media/platform/sti/c8sectpfe/Kconfig       |  1 -
 .../media/platform/sti/c8sectpfe/c8sectpfe-core.c  |  9 +++--
 4 files changed, 58 insertions(+), 17 deletions(-)

-- 
1.9.1
