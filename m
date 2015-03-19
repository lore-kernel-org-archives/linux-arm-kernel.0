From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Mar 2015 15:52:43 +0100
Subject: [PATCH 0/2] tc3589x OF only enforcement
Message-ID: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches removes the non-DT probe/config path from the
TC3589x driver. I suggest merging both through the MFD tree if
Dmitry can ACK the input patch.

Linus Walleij (2):
  input: keypad: tc3589x: localize platform data
  mfd: tc3589x: enforce device-tree only mode

 drivers/gpio/Kconfig                    |  1 +
 drivers/gpio/gpio-tc3589x.c             |  3 --
 drivers/input/keyboard/tc3589x-keypad.c | 58 +++++++++++++++++++--------------
 drivers/mfd/Kconfig                     |  1 +
 drivers/mfd/tc3589x.c                   |  9 -----
 include/linux/mfd/tc3589x.h             | 23 -------------
 6 files changed, 35 insertions(+), 60 deletions(-)

-- 
1.9.3
