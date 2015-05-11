From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 May 2015 15:11:18 +0200
Subject: [PATCH v2] Mediatek SCPSYS power domain support
Message-ID: <1431349882-12260-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the MediaTek SCPSYS unit.

The SCPSYS unit handles several power management related tasks such
as thermal measurement, DVFS, interrupt filter and low level sleep
control.

The initial support only contains the generic power domain handling.
This is needed to turn on power to the different power domains.

The driver is quite straight forward now. Due to the lack of a better
place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
several other tasks that also do not fit into some specific subsystem
this probably is a good place for this driver.

Please review, any input welcome.

Sascha

changes since v1:
- make MFG_ASYNC a subdomain of MFG_2D and MFG_2D a subdomain of MFG
- Add (now hopefully properly) infracfg register handling again
- Add clock handling
- Fix on/off mixup in error message
- Make readonly data const
- Fix MODULE_LICENSE to GPL v2

changes since RFC:

- add a commit log to driver patch
- drop manipulating infracfg registers for now, can be added (properly)
  later
- Add warning messages when errors occur
- add NULL pointer check for kmalloc
- Enable all power domains when PM is disabled to allow consumers to work
