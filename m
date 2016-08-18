From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 18 Aug 2016 12:35:26 +0200
Subject: Merging code with arch condition into head.S
Message-ID: <CACna6rxhhD5kfa1oJzqp2dQxBhjaUzdTkNPMcm-+iNvQHD8yzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to ask for help with writing my arcm/arm/boot/compressed/head-foo.S.

There is probably a bug in bootloader on *a lot* market-available
devices that needs a very early fix executed during decompression. If
we don't implement it, Broadcom Northstar devices hang in 25% of tries
and BCM53573 devices don't boot at all.

The problem is ARCH_BCM_5301X is used with ARCH_MULTI_V7, so we really
shouldn't merge some extra code into head.S and execute it
unconditionally. I'd like to ask if you can suggest some idea for a
sane architecture check.

Ideally I'd read it from DT, but I don't think I can read machine
"compatible" from ASM. As alternative I could try reading SoC chip ID
from ChipCommon component which Broadcom always maps at 0x18000000.
Would that be safe enough? Could reading from such offset do any harm
on other devices?

Maybe you have some better ideas?

I was looking for similar solutions in the kernel, but I found none.
There are e.g. head-sa1100.S and head-sharpsl.S but they seem to be
used on architectures that don't use ARCH_MULTI_V7.

-- 
Rafa?
