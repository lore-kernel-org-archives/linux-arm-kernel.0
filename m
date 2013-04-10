From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 10 Apr 2013 13:54:08 -0500
Subject: [PATCH] ARM: at91/dts: at91sam9g20ek_2mmc: fix card detection
In-Reply-To: <1365613532-18919-1-git-send-email-robertcnelson@gmail.com>
References: <1365613532-18919-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <CAOCHtYjqaiR9eiZ-CXHuHyB-bij0Ew6p930Nd88SmeFSHMMRZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 12:05 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
> Use cd-inverted to fix card detection on the at91sam9g20-ek Rev C Dev board.

Please Ignore this patch for now... As after more testing it looks
more like pinmux problem..  Aka removing a card (used to load
at91bootstrap/u-boot) during boot and then inserting the card again
after "Waiting for root device" shows up.. Results in nothing...

[    1.023437] atmel_mci fffa8000.mmc: version: 0x210
[    1.031250] atmel_mci fffa8000.mmc: no DMA channel available
[    1.039062] atmel_mci fffa8000.mmc: using PDC
[    1.132812] atmel_mci fffa8000.mmc: Atmel MCI controller at
0xfffa8000 irq 30, 2 slots
[    1.140625] Waiting for root device /dev/mmcblk0p2...

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
