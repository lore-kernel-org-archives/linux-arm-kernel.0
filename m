From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 May 2013 17:07:49 +0400
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add Ether support
In-Reply-To: <20130513004314.GD22911@verge.net.au>
References: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
 <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
 <518CCB6A.2060303@cogentembedded.com> <20130513004314.GD22911@verge.net.au>
Message-ID: <5190E5A5.8030605@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-05-2013 4:43, Simon Horman wrote:

>>> Add Ether clock and platform device for R8A7779 SoC; add a function to
>>> register this device with board-specific platform data.

>>> Based on a similar change for the r8a7779 by Sergei Shtylyov.

>>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[...]

>>> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
>>> index 2e919e6..95b8f7e 100644
>>> --- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
>>> +++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
>>> @@ -1,9 +1,12 @@
>>>   #ifndef __ASM_R8A7790_H__
>>>   #define __ASM_R8A7790_H__
>>>
>>> +#include <linux/sh_eth.h>
>>> +
>>>   void r8a7790_add_standard_devices(void);
>>>   void r8a7790_clock_init(void);
>>>   void r8a7790_pinmux_init(void);
>>>   void r8a7790_timer_init(void);
>>> +void r8a7790_add_ether_device(struct sh_eth_plat_data *pdata);

>>     Perhaps better place is right after r8a7790_add_standard_devices()...

> Is the implication that the struct sh_eth_plat_data can be defined
> in setup-r8a7790.c?

    No, why?

> Or do you for see adding a struct sh_eth_plat_data
> parameter to r8a7790_add_standard_devices() ?

    Not at all.

WBR, Sergei
