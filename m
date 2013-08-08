From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Aug 2013 07:26:48 -0500
Subject: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
 <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
Message-ID: <52038E88.2050604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 03:45 AM, Russ Dill wrote:
>   In reference to
> the M3 handling it, the M3 wouldn't know which devices have a driver
> bound and which don't.
Does it need to? M3 firmware can pretty much define "I will force the 
device into low power state, and if the drivers dont handle things 
properly, fix the darned driver". M3 behavior should be considered as a 
"hardware" as far as Linux running on MPU is concerned, and firmware 
helps change the behavior by accounting for SoC quirks. *if* we have 
ability to handle this in the firmware, there is no need to carry this 
in Linux.

-- 
Regards,
Nishanth Menon
