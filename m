From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 21 Oct 2014 10:26:16 +0800
Subject: [PATCH v2 0/3] i2c/at91: add support PM functions
Message-ID: <1413858379-22865-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

The patches is to add the PM functions support for the at91 i2c controller.

It is based on the i2c/for-next branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git.

Best Regards,
Wenyou Yang

------
Change log:
v2.0

According to the advice from Kevin Hilman, 
1./ Wrap the runtime suspend/resume functions in CONFIG_PM instead of CONFIG_PM_RUNTIME.
2./ Call the runtime suspend/resume functions directly in the system suspend/resume.

Wenyou Yang (3):
  i2c/at91: add support for runtime PM
  i2c/at91: add support for system PM
  i2c/at91: adopt pinctrl support

 drivers/i2c/busses/i2c-at91.c |   74 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

-- 
1.7.9.5
