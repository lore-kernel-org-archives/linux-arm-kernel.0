From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Wed,  8 Aug 2018 17:26:59 +0200
Subject: [PATCH v1 0/7] Add support for the Turris Mox router
Message-ID: <20180808152706.21727-1-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds preliminary support for the Turris Mox SOHO router developed by CZ.NIC
to mainline kernel.

The first patch fixes the corresponding pinctrl driver.

The second patch adds a new type of bus called "moxtet" to the kernel, via which
the different Mox modules can be found and configured.

The third patch adds support for GPIOs found on the module with SFP cage. These
GPIOs are configured via the "moxtet" bus.

The fourth and fifth patches add support for watchdog found on Armada 37xx SOCs.

The sixth patch fixes a weird bug I keep encountering in the mvneta driver on
Armada 3720 SOCs. This may be deleted or changed in the future version of this
patchset depending on what the networking guys will think about this.

The seventh patch adds Turris Mox device tree.

Marek
