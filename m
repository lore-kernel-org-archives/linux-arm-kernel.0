From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 21:27:56 +0100
Subject: [PATCH] ARM: add Versatile Express defconfig
In-Reply-To: <3093351151219722808@unknownmsgid>
References: <1296501243-28917-1-git-send-email-linus.walleij@linaro.org>
	<3093351151219722808@unknownmsgid>
Message-ID: <AANLkTimzz5RAeuAWwss5krD_ogtN6u5ioQUS+e1ecyiB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/31 Will Deacon <will.deacon@arm.com>:

>> +CONFIG_SMP=y
>> +CONFIG_VMSPLIT_2G=y
>> +CONFIG_HOTPLUG_CPU=y
>
> This will probably cause a compile-time error with a mainline kernel
> because the necessary hotplug functions aren't implemented for vexpress.

Does compile for me on 2.6.38-rc1 (after I avoid an compiler ICE
on the NOR flash driver by deselecting it, I don't blame the kernel
for that one tho):

Image Name:   Linux-2.6.38-rc1
Created:      Mon Jan 31 21:21:16 2011
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    4740192 Bytes = 4629.09 kB = 4.52 MB
Load Address: 0x60008000
Entry Point:  0x60008000
  Image arch/arm/boot/uImage is ready

Might this have something to do with it:

git log arch/arm/mach-vexpress/hotplug.c
commit e9882777d992b76e0b80deadd66ad886c25f5d1f
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Dec 19 11:33:12 2010 +0000

    ARM: CPU hotplug: add Versatile Express hotplug CPU support

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I don't know if it boots tho, if you pack up a Vexpress and
mail it to my place I promise I will make more than just
compiletests ;-)

Linus Walleij
