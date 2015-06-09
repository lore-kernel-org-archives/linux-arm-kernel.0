From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  9 Jun 2015 23:37:53 +0200
Subject: [PATCH 0/8] mfd/power/phy: Add support for otg vbus detection via axp
 pmic
Message-ID: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a series which adds the beginning of power-supply support to
the axp20x pmic code. My primary reason for working on this is to
enable the use of the usb power-supply bits in the pmic to for vbus
detection on boards which do not have a vbus-det gpio, and instead
rely on the pmic for vbus detection.

After I had written most of the vbus power-supply driver code I
became aware of Bruno Pr?mont's (in the CC) previous work on this
our drivers are mostly the same, and I've borrowed some code from
his driver to add support for min-volt / max-curr properties.

The big difference between our 2 drivers is that mine driver uses
a devicetree child node / mfd cell per power-supply, so one for
each of the usb-power, ac-power / battery-charger and rtc-backup-bat-charger
bits.

Depending on the board each of those must be enabled / disabled separately
in devicetree as most boards do not use all 4. So in dt each one needs its
own child-node of the axp20x node. Another reason for using separate child
nodes for each is so that other devicetree nodes can have a power-supply
property with a phandle referencing a node representing a single
power-supply.

Regards,

Hans
