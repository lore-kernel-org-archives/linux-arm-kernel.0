From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu,  1 Nov 2012 07:04:12 +0800
Subject: [PATCH v3 0/9]: pinctrl-single support DT
Message-ID: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v3:
1. Add more comments in document.
2. Replace pcs_readl() & pcs_writel() by pcs->read() & pcs->write().
3. Clean code.

v2:
1. Remove "pinctrl-single,gpio-mask". Since GPIO function is one of the
mux function in the pinmux register of both OMAP and PXA/MMP silicons.
Use "pinctrl-single,function-mask" instead.
2. Remove "pinctrl-single,gpio-enable" & "pinctrl-single,gpio-disable".
Use "pinctrl-single,gpio-func" instead. Because GPIO mode is only one
of the mux functions in the pinmux register. Defining "gpio-enable" &
"gpio-disable" are redundant.
3. Define register with __iomem, not u32 type.
4. Remove "pinctrl-single,input-schmit-shift",
"pinctrl-single,power-source-shift", "pinctrl-single,bias-shift". All
these properties could be calculated by mask fields.
5. Return -EPROBE_DEFER if pinmux could be got in device driver. And
the device driver would be probed again deferred.
