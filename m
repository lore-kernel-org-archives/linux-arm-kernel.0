From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jan 2013 17:42:05 +0100
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
Message-ID: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear drivers/{char,misc}/ maintainers,

This patch series implements a simple driver for 7-segment displays
connected over GPIOs through a BCD encoder. The userspace interface of
the driver is very simple: just a "value" file in the sysfs directory
of the device, which can be written to (changes the value shown on the
7-segment display) and read (gives the current value).

This driver has been tested on Marvell Armada 370 and Marvell Armada
XP evaluation boards, but could potentially be used by anybody having
a 7-segment display controlled over GPIOs with a BCD encoder.

 * Patch 1 adds the driver itself, together with the Device Tree
   binding documentation.

 * Patch 2 and 3 add the necessary Device Tree information to use this
   driver on the Armada 370 and Armada XP evaluation boards.

Best regards,

Thomas
