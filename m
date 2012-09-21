From: rabin@rab.in (Rabin Vincent)
Date: Fri, 21 Sep 2012 23:33:52 +0200
Subject: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
In-Reply-To: <1346943430-18236-3-git-send-email-kishon@ti.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
 <1346943430-18236-3-git-send-email-kishon@ti.com>
Message-ID: <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/6 Kishon Vijay Abraham I <kishon@ti.com>:
> All the PHY configuration other than VBUS, ID GND and OTG SRP are removed
> from twl6030. The phy configurations are taken care by the dedicated
> usb2 phy driver. So twl6030 is made as comparator driver for VBUS and
> ID detection.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

USB doesn't work on pandaboard on linux-next, and bisection shows this
patch.  Unfortunately, I can't provide a dmesg log because USB is the
only way I currently have to get one out(!), but presumably it's because
this omap-usb2 device is never registered?  Looks like this breaks
non-dt USB on pandaboard; is that intended?

(I see that current linux-next doesn't have USB support even in
 pandaboard DT, but I see patches for that on the lists)
