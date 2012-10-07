From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 07 Oct 2012 03:53:00 +0200
Subject: [PATCH 0/6] ARM: Add support for Broadcom BCM476x SoCs
Message-ID: <20121007015300.828366635@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Howdy,

  this patchset adds (minimal) support for the Broadcom BCM476x ARM based
SoCs to the kernel, not to be confused with the already supported MIPS
based BCM47xx SoC and other BCM47xx WiFi and GPS produced by Broadcom.

This BCM476x is a DT-only multi-platform ARM platform and, at this spin,
minimal in the features (boots nicely into initrd/busybox only) but also
in the new code required, thanks to the existing drivers (and sweet DT)
easily hooked up with the rest.

Additional support is being worked on. Pinctrl, clocks and gpios are
almost ready for review. DMA (PL080) and/or sdhci have issues. Regulators
(BCM59040) are minimal and usb (DWC OTG) only attemped reusing s3c-hsotg.
Other fancy stuff (not too much) later and not all.

All this is my code, originating by me. The reference code I used is
published by TomTom (my employer, who is aware but not involved at all)
as part of the GPL compliance program but I don't plan to re-publish
or maintain any part of it.

It's based on a random pre v3.7-rc1 commit (eb0ad9c) with mainlined
multi-platform support and Stephen's patch to add DEBUG_LL to it.

Special thanks go to Stephen Warren who, with the recently mainlined
BCM2835, showed how to do things cleanly since the beginning and
involuntarily spurred me to act.

Any feedback is welcome.

Thanks,
Domenico
