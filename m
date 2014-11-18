From: dianders@chromium.org (Doug Anderson)
Date: Tue, 18 Nov 2014 15:49:54 -0800
Subject: [PATCH 0/2] Pinctrl fixes for rockchip
Message-ID: <1416354596-15013-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches fix some pinctrl issues on rockchip.  The first
fixes a real issue where interrupts were being left on in
suspend/resume and waking the system up when they shouldn't.  The
second fixes purely theoretical problems and could be considered more
of an RFC patch.

I've tested these patches more extensively on a non-mainline tree but
have done basic compile and boot testing on mainline.  I don't have
suspend/resume working so well on mainline yet, so I haven't tested
fully there.


Doug Anderson (2):
  pinctrl: rockchip: Handle wakeup pins
  pinctrl: rockchip: Fix enable/disable/mask/unmask

 drivers/pinctrl/pinctrl-rockchip.c | 51 +++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
