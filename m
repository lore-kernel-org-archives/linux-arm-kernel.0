From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Jul 2013 16:59:25 -0400
Subject: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
In-Reply-To: <51F0F283.5080900@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <1374712099-32095-2-git-send-email-santosh.shilimkar@ti.com>
 <51F0F283.5080900@ti.com>
Message-ID: <51F191AD.9020108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 July 2013 05:40 AM, Sekhar Nori wrote:
> On Thursday 25 July 2013 05:58 AM, Santosh Shilimkar wrote:
>> This driver no longer uses definitions from mach/hardware.h.
>> On the other hand, including this header breaks this driver
>> on non-davinci platforms which don't have such a header.
>>
>> Fix it.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> One minor nit:
> 
>> ---
>>  drivers/i2c/busses/i2c-davinci.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index fa55605..ddaa2a3 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -41,7 +41,6 @@
>>  #include <linux/of_i2c.h>
>>  #include <linux/of_device.h>
>>  
> 
> You can now remove this empty line too.
> 
Yes. Updated patch below with your ack added.

Regards,
Santosh

>From d7ae1c488ebae19028f33abff76c4d684271a7fb Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 23 Jul 2013 15:40:46 -0400
Subject: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include

This driver no longer uses definitions from mach/hardware.h.
On the other hand, including this header breaks this driver
on non-davinci platforms which don't have such a header.

Fix it.


Cc: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index fa55605..5898df3 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -40,8 +40,6 @@
 #include <linux/gpio.h>
 #include <linux/of_i2c.h>
 #include <linux/of_device.h>
-
-#include <mach/hardware.h>
 #include <linux/platform_data/i2c-davinci.h>
 
 /* ----- global defines ----------------------------------------------- */
-- 
1.7.9.5
