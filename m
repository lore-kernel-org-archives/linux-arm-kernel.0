From: hector.oron@gmail.com (Hector Oron)
Date: Thu, 25 Aug 2011 01:03:55 +0200
Subject: i.MX multi SoC patches
In-Reply-To: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
References: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAODfWeFeaw2+xe01c5fiSr1tYsdM8J8ahZz8t-B7uuD+-P0GCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

2011/8/24 Sascha Hauer <s.hauer@pengutronix.de>:
> This is hopefully the last iteration of the patches for compiling
> all ARMv4/v5 based i.MXs together. CONFIG_ARM_PATCH_PHYS_VIRT
> lost its experimental status and we can still build uImages
> even with CONFIG_AUTO_ZRELADDR enabled. This series selects
> these options and makes a multi SoC image the default.
> Also, we can now build all i.MX5 SoCs into a single image.
> This series also updates the defconfigs.

Thanks very much for doing this work, it is very much appreciated.
I have not yet been able to test this work at runtime, but I have
attempted to compile
your branch 'imx-features' which seems to keep all this work. I have
noticed a name
clashing producing the following compile time error:

arch/arm/plat-mxc/devices/platform-pata_imx.c:33: error:
?MX51_INT_ATA? undeclared here (not in a function)

Lurking a bit in the archive I noticed that Uwe patch
<http://patchwork.ozlabs.org/patch/106633/> it is assumed, but not applied.
Attached there is a refreshed patch which applies to your 'imx-features' branch.

With kind regards,
-- 
?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ARM-mx5-fix-remaining-unconsistent-names-for-irqs-v2.patch
Type: text/x-patch
Size: 8976 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110825/506838f5/attachment-0001.bin>
