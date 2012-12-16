From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 17 Dec 2012 03:50:12 +0800
Subject: [imx:work/efikasb 4/29] drivers/usb/chipidea/otg.c:54:4: error:
 'struct ci13xxx' has no member named 'otg'
Message-ID: <50ce25f4./78UjnbIRjv7NLWj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.pengutronix.de/git/imx/linux-2.6.git work/efikasb
head:   4de30514cbd7126ba06062e39ba4701f2bca1a37
commit: 919553ea44720e0b8ea0275c32254f5e325aba11 [4/29] usb: chipidea: add otg file
config: make ARCH=x86_64 allyesconfig

Note: the imx/work/efikasb HEAD 4de3051 builds fine.
      It only hurts bisectibility.

All error/warnings:

drivers/usb/chipidea/otg.c: In function 'ci_hdrc_otg_init':
drivers/usb/chipidea/otg.c:54:4: error: 'struct ci13xxx' has no member named 'otg'
drivers/usb/chipidea/otg.c:55:4: error: 'struct ci13xxx' has no member named 'otg'
drivers/usb/chipidea/otg.c:57:29: error: 'struct ci13xxx' has no member named 'otg'

vim +54 drivers/usb/chipidea/otg.c

919553ea Peter Chen 2012-11-19  48   * This function create otg struct, if the device can switch between
919553ea Peter Chen 2012-11-19  49   * device and host.
919553ea Peter Chen 2012-11-19  50   */
919553ea Peter Chen 2012-11-19  51  int ci_hdrc_otg_init(struct ci13xxx *ci)
919553ea Peter Chen 2012-11-19  52  {
919553ea Peter Chen 2012-11-19  53  	/* Useless at current */
919553ea Peter Chen 2012-11-19 @54  	ci->otg.set_peripheral = ci_otg_set_peripheral;
919553ea Peter Chen 2012-11-19  55  	ci->otg.set_host = ci_otg_set_host;
919553ea Peter Chen 2012-11-19  56  	if (!IS_ERR_OR_NULL(ci->transceiver))
919553ea Peter Chen 2012-11-19  57  		ci->transceiver->otg = &ci->otg;

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
