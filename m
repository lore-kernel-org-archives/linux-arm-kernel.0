From: andrea.adami@gmail.com (Andrea Adami)
Date: Tue, 8 Apr 2014 14:29:35 +0200
Subject: ARM: SA1100: collie broken (and fixes pending)
Message-ID: <CAAQYJAvBwf4ohnBajvKwSYRWr-9QxD4=Mrrzyu2=9DvHUSh3ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

there are two patchsets pending for collie/sa1110:

http://archive.arm.linux.org.uk/lurker/message/20131116.220725.42397482.en.html
http://archive.arm.linux.org.uk/lurker/message/20131215.042807.213f9035.en.html

>From the first patchset we need at least the first 3:
      arm: sa1100: add cpu clock
      fbdev: sa1100fb: make use of device clock
      pcmcia: sa1100: make use of device clock

The second has been tested as well by Linus Walleij.

Unfortunately there is now a conflict about clk_get_rate() introduced
with commit # 0ad04fb "ARM: SA1100: Create dummy clk_get_rate() to
avoid build failures".

To add more fun, there is a second issue:

MODPOST 247 modules
ERROR: "clk_set_rate" [drivers/usb/phy/phy-generic.ko] undefined!

so to build 3.14 I had to revert 0ad04fb and to add a dummy clk_set_rate() [1].
Please verify that.

I think it is urgent that we sort this out to avoid more differences in future.

Thanks in advance

Andrea

[1]
http://cgit.openembedded.org/meta-handheld/tree/recipes-kernel/linux/linux-yocto-3.14/collie/arm-sa1100-dummy-clk_set_rate.patch
