From: patrick@puiterwijk.org (Patrick Uiterwijk)
Date: Tue, 29 Mar 2016 13:56:51 +0000
Subject: [patch] ARM: mvebu: fix usb on Linksys Caiman
Message-ID: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches fix the USB ports on Linksys Caiman (WRT1200AC) on 4.6rc1.
After a lot of trial and error, I found out that if there's any unit
with name "usb at 58000" defined, none of the USB ports work, but if I
change it to anything else, the USB3 port comes up. And if I then also
bring the linksys.dtsi unit name in sync (and different from USB at 58000),
the USB2 port also comes up.

I can change it to literally anything else: nonsense at 58000 and usb at 58001
work, it's only usb at 58000 that doesn't work as far as I have found.
Since the ehci-orion documentation gives the example of ehci at 50000, I just
brought all of the Orion EHCI device tree definitions in sync with this.
