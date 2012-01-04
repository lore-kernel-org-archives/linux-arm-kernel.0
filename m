From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  4 Jan 2012 10:26:32 +0800
Subject: [PATCH v4 0/3] implement pinmux for arch-mmp
Message-ID: <1325643995-20745-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

#1 & #2 patch are based on pinctrl/for-next branch.
#3 patch is based on arm-soc/for-next branch since it replies the new pxa-gpio
driver.

Changelog v4->v3:
1. Rename PINMUX_* to PINCTRL_*.
2. Remove the CONFIG_PINMUX in pxa-gpio driver.

Changelog v3->v2:
1. Avoid to use number in groups definition. Use macro instead.
2. Replace func array with mux array. There's a risk of align func array
and group array. Both pin and mux are defined in new mux array.
3. Support gpio again in gpio-pxa.
4. If multiple pins can be configured to same GPIO pin, define new specific
gpio group.

Changelog v1->v2:
1. Split pxa3xx pinmux driver to more pieces.
2. Add PXA168/PXA910/PXA930/MMP2 silicon support.
3. Now only enable it in arch-mmp.
4. Now all predefined pins are enabled by default. Although some devices
are not used, they would be declared in arch-pxa. It would result define
unnecessary pins in platform.
5. Remove gpio support since it's depend on some gpio-pxa patches in
arm-soc trees.
