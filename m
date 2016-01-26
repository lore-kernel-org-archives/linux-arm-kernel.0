From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 26 Jan 2016 20:22:51 +0200
Subject: [BISECTED] v4.5-rc1 mvebu/kirkwood-pinctrl regression
Message-ID: <20160126182251.GF15550@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On kirkwood-openrd-client SDIO stopped working, and I get the following
pinctrl logs:

[    0.096502] pinctrl core: initialized pinctrl subsystem
[    1.765275] kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver
[    5.375416] kirkwood-pinctrl f1010000.pin-controller: unsupported function sdio on pin mpp12
[    5.383972] pinctrl core: failed to register map default (5): invalid type given

Bisected to:

commit 0581b16b184031e767f64d20a93f65433d678685
Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date:   Sat Nov 28 11:26:49 2015 +0100

    pinctrl: mvebu: complain about missing group after checking variant

Reverting this patch makes my rootfs (SD card) accessible again.

A.
