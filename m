From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 May 2014 10:06:24 +0200
Subject: [PATCH v4 0/2] input: Add new sun4i-ts driver for Allwinner sunxi
 SoC's rtp controller
Message-ID: <1399795586-18919-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Since Maxime rightfully pointed out an error in my resend of v3, here is v4
with that fixed.

Note the second patch which adds hwmon functionality has been reviewed by
the hwon subsystem maintainer, and the sun?i*.dts changes to enable this
have already been upstreamed.

Changes since v1:
-Use devm_kzalloc and devm_hwmon_device_register_with_groups as suggested
 by Guenter Roeck
-Various small cleanups suggested by Thomas Petazzoni
-Add open/close methods and enable/disable the input related interrupts from
 there as suggested by Dmitry

Changes since v2:
-Addressed review comments from Dmitry
-Addressed review comments from Guenter
-Addressed review comments from Maxime
-Initialize ignore_fifo_data to true, the very first coordinate can be
 wrong too

Changes since v3:
-Rename compatible from sun4i-ts to sun4i-a10-ts to match the dts entries
 which are already upstream

Thanks & Regards,

Hans
