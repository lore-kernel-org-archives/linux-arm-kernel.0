From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 20:11:09 +0100
Subject: [PATCH v2 00/13] musb: Add support for the Allwinner sunxi musb
 controller
Message-ID: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my patch-set to add support for the musb variant found on
Allwinner sunxi SoCs.

Changes since the original posting:
-Removed the sunxi specific phy functions, instead the id / vbus gpio polling
 has been moved to the phy-sun4i-usb driver and their status is exported
 through extcon for the sunxi-musb glue
-Stop using syscon, instead Maxime Ripard's sunxi SRAM controller driver is now
 used

This should address all review remarks against v1 of this patch-set, so
hopefully we can start merging this upstream.

The "musb: Add support for the Allwinner sunxi musb" commit relies on
Maxime's SRAM controller patches, so those need to get merged first,
but the phy-sun4i-usb and musb preparation patches can be merged already
(assuming there are no objections).

And then once the SRAM controller patches are in next we can also merge
the "musb: Add support for the Allwinner sunxi musb" commit and the dts
changes.

Regards,

Hans
