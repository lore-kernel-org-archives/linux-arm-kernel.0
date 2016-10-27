From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 27 Oct 2016 17:24:53 +0530
Subject: [PATCH v3] ARM: davinci: da8xx: Fix some redefined symbol warnings
In-Reply-To: <7026f012-ffce-cc28-85be-9a5cd26de60f@ti.com>
References: <1477485542-10555-1-git-send-email-abailon@baylibre.com>
 <1477485542-10555-2-git-send-email-abailon@baylibre.com>
 <7026f012-ffce-cc28-85be-9a5cd26de60f@ti.com>
Message-ID: <ca32fd12-5299-02e8-24c4-501dda4291ab@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 October 2016 05:13 PM, Sekhar Nori wrote:
> On Wednesday 26 October 2016 06:09 PM, Alexandre Bailon wrote:
>> Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
>> but da8xx-cfgchip.h intend to replace them.
>> The usb-da8xx.c is using both headers, causing redefined symbol warnings.
> 
> Looks like this is not true for v4.9-rc2 and so I don't see any warnings

Ah, just noticed that _this_ is the patch that introduces
da8xx-cfgchip.h into usb-da8xx.c. So this is the patch that introduces
the warnings (and fixes them).

I can queue this for v4.10 (with Greg's ack) if you change the
description to make it about cleaning up duplicated defines between
da8xx-cfgchip.h and usb-davinci.h and not talk about "redefined symbol
warnings".

Also, when adding a header file, can you please keep it sorted in
alphabetical order.

Thanks,
Sekhar
