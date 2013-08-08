From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 11:03:18 -0400
Subject: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <52038E88.2050604@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
 <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
 <52038E88.2050604@ti.com>
Message-ID: <5203B336.90102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$subject and patch don't match.

On Thursday 08 August 2013 08:26 AM, Nishanth Menon wrote:
> On 08/08/2013 03:45 AM, Russ Dill wrote:
>>   In reference to
>> the M3 handling it, the M3 wouldn't know which devices have a driver
>> bound and which don't.
> Does it need to? M3 firmware can pretty much define "I will force the device into low power state, and if the drivers dont handle things properly, fix the darned driver". M3 behavior should be considered as a "hardware" as far as Linux running on MPU is concerned, and firmware helps change the behavior by accounting for SoC quirks. *if* we have ability to handle this in the firmware, there is no need to carry this in Linux.
> 
I agree with Nishant. I don't like this patch and IIRC, I gave same
comment in the last version. Linux need not know about all such firmware
quirks. Also all these M3 specific stuff, should be done somewhere
else. Probably having a small M3 driver won't be a bad idea.

Regards,
Santosh
