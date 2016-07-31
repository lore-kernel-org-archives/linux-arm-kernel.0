From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 31 Jul 2016 19:02:32 +0800
Subject: [PATCH v2 0/2] Add support for Allwinner A64 mmc controller
Message-ID: <20160731110234.3593-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 has a slightly modified version of the Allwinner MMC controller.

It do not have "output" or "sample" clock input, instead, it can calibrate the
delay internally.

This series of patch added the calibrate feature to the sunxi-mmc driver. It
is based on works by Andre Przywara <andre.przywara@arm.com>, and now it
depends on the patch set sent recently by Hans de Geode <hdegoede@redhat.com>,
which disabled "output" and "sample" clock on A10/13.
( http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/446187.html )

As the clock and device tree patch for Allwinner A64 is not yet merged, the
patch set contains no patch to enable it.
