From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 25 Dec 2014 13:25:18 +0100
Subject: [PATCH 3.19 REGRESSION FIX] ARM: dts: sun6i: ippo-q8h-v5: Fix serial0
 alias
Message-ID: <1419510319-32400-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, ChenYu,

The Ippo q8h has its serial console connected to the r-uart. Adjust the
serial0 alias to match.

This fixes the kernel serial console no longer working since 3.19-rc1, because
8250_dw.c now honors dt aliases, causing the serial console to be ttyS5 rather
then being ttyS0, as it was in 3.18 and before.

Note that adjusting bootargs instead is not an acceptable fix, because
console=ttyS0,115200 is used by a lot of bootscripts, etc. and this should
continue to work.

Maxime, can you please queue this up as a fix for 3.19 ?

Regards,

Hans
