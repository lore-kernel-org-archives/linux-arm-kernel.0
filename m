From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:24:02 +0100
Subject: usb: avoid warnings for unused pm functions
Message-ID: <1456932255-71725-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series addresses a couple of similar warnings in USB
host and phy drivers. In each case, there is a mismatch between
the references to some functions and the #ifdef hiding those
functions (if any).

The series gets rid of all those #ifdes and instead changes
the drivers that don't already get it wrong to annotate
the functions as __maybe_unused. However, I am not changing
any files that consistently get the #ifdefs right.

	Arnd

[PATCH 1/6] usb: host: unhide suspend/resume declarations
[PATCH 2/6] usb: xhci-mtk: use __maybe_unused to hide pm functions
[PATCH 3/6] usb: ohci-at91: use __maybe_unused to hide pm functions
[PATCH 4/6] usb: ehci-atmel: use __maybe_unused to hide pm functions
[PATCH 5/6] phy: dm816x: use __maybe_unused to hide pm functions
[PATCH 6/6] phy: twl4030: use __maybe_unused to hide pm functions
