From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 25 Aug 2015 17:22:07 +0100
Subject: [PATCH 0/3] c8sectpfe
Message-ID: <1440519730-486-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

This series includes a couple of fixes for the c8sectpfe Linux dvb driver.

One was caused by omitting a patch from the original c8sectpfe series which
defined the ssc2 and ssc3 dt nodes, which was then used by the later DT patch.

This patch is included, along with the original patch which you reverted.

Also Valentin Rothberg spotted LIBELF32 Kconfig symbol I was selecting in the
Kconfig, this isn't required upstream and is left over legacy so I've removed
it.

Sorry for the delay in sending these fixes, I've been on holiday for the last
3 weeks.

kind regards,

Peter.

Peter Griffin (3):
  ARM: DT: STi: stihxxx-b2120: Add pulse-width properties to ssc2 & ssc3
  ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB DT node.
  [media] c8sectpfe: Remove select on undefined LIBELF_32

 arch/arm/boot/dts/stihxxx-b2120.dtsi         | 48 ++++++++++++++++++++++++++--
 drivers/media/platform/sti/c8sectpfe/Kconfig |  1 -
 2 files changed, 46 insertions(+), 3 deletions(-)

-- 
1.9.1
