From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 24 Dec 2014 20:19:17 +0100
Subject: [PATCH 3.19 REGRESSION FIX] ARM: dts: Fix missing usb0_reset for
 sun4i / sun5i
Message-ID: <1419448758-22371-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

The recent sun4i-usb-phy changes to add (preliminary) support for the oth phy,
cause the ehci/ohci controllers to no longer work on sun4i / sun5i, because
the phy driver refuses to load due to a missing usb0_reset reset controller
in the dts files for sun4i / sun5i:

[    0.094293] sun4i-usb-phy 1c13400.phy: failed to get reset usb0_reset
[    0.094326] sun4i-usb-phy: probe of 1c13400.phy failed with error -22

This patch fixes this, please queue this up as a fix for 3.19 .

Regards,

Hans
