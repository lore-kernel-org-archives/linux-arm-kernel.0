From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 14 Dec 2016 13:57:07 +0100
Subject: [PATCH 0/2] video/sti/cec: add HDMI notifier support
Message-ID: <1481720229-7587-1-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following (copying !) what Hans have done in this serie of patches
http://www.spinics.net/lists/linux-media/msg109141.html
I have implemented hdmi notifier in hdmi controled and stih-cec drivers.

Those patches should be applied on top of Hans patches for exynos.

I have tested hdmi notifier by pluging/unpluging HDMI cable and check
the value of the physical address with "cec-ctl --tuner".
"cec-compliance -A" is also functional.

Hans, I haven't move stih-cec out of staging because I don't have the
exact branch to test it, can you do the move for stih-cec after applying
those patches ?

Regards,
Benjamin

Benjamin Gaignard (2):
  sti: hdmi: add HDMI notifier support
  stih-cec: add hdmi-notifier support

 .../devicetree/bindings/media/stih-cec.txt         |  2 ++
 arch/arm/boot/dts/stih407-family.dtsi              | 12 ---------
 arch/arm/boot/dts/stih410.dtsi                     | 15 ++++++++++-
 drivers/gpu/drm/sti/Kconfig                        |  1 +
 drivers/gpu/drm/sti/sti_hdmi.c                     | 15 +++++++++++
 drivers/gpu/drm/sti/sti_hdmi.h                     |  2 ++
 drivers/staging/media/st-cec/Kconfig               |  1 +
 drivers/staging/media/st-cec/stih-cec.c            | 29 +++++++++++++++++++++-
 8 files changed, 63 insertions(+), 14 deletions(-)

-- 
1.9.1
