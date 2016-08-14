From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 14 Aug 2016 20:27:54 +0200
Subject: [PATCH 0/7] musb: sunxi: Add support for run-time changing dr-mode
 through sysfs
Message-ID: <1471199281-5494-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a patch series which implements run-time changing the dr-mode
of sunxi musb controllers through the (already existing) musb "mode"
sysfs attribute.

This is useful on boards where there is no id pin, e.g. some tv-boxes
use the musb controller to get an extra usb A port without needing
a hub chip. Except for the missing id pin when using a usb A<->A cable
these ports can do peripheral mode just fine. This series makes it
possible to do e.g. this by doing echo "peripheral" > mode before
plugging in the usb A<->A cable.

This series has both sun4i-usb-phy driver and sunxi-musb-glue changes,
both are necessary for the run-time changing to work, but they can be
merged independently without breaking anything.

Please review (and if no issues are found merge).

Thanks & Regards,

Hans
