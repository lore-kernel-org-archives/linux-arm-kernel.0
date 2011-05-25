From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2011 11:03:28 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <201105221203.03970.arnd@arndb.de>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
	<201105221203.03970.arnd@arndb.de>
Message-ID: <BANLkTinrBgA8Zw03AzGFxAiY-84Hgxfcxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/22 Arnd Bergmann <arnd@arndb.de>:
> On Saturday 21 May 2011 19:42:34 Grant Likely wrote:
>> 1) drop amba-bus entirely and use platform_device everywhere, similar
>> to what OMAP has done
>> 2) strictly create amba_devices for nodes compatible with "arm,amba-device"
>> 3) be intelligent about amba device creation; create an amba_device
>> only for devices we know are driven with amba_driver.
>
> Or maybe
>
> 4) Use amba_device for all devices on an amba bus (identified by
> the compatible property of the bus), but mark the ones that do
> not have primecell compatible registers so that the amba bus
> does not try to look at them but instead takes the information
> from the device tree.

Currently the amba/primecell bus driver in drivers/amba/bus.c
will have the hardware registers override any data provided
from the board.

There are pending patches to instead have the board potentially
override the hardware, see:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6829/1

The reason is that some of our hardware has newer revisions
of the PrimeCells and still the hardware registers have not
been updated properly. (Yes, the people involved have been
informed.)

So you also have a case where you may want to provide an ID
and have it override the ID present in the hardware.

Yours,
Linus Walleij
