From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 18 Sep 2012 14:49:50 +0800
Subject: [PATCH] ARM: OMAP: OMAP_DEBUG_LEDS needs to select LEDS_CLASS
In-Reply-To: <CAK5ve-LXv76vuBLHQQtREHn_ZogUsbyqzz2-uTHT_Ps-9vS3Pw@mail.gmail.com>
References: <1347939042.15578.1.camel@phoenix>
 <CAK5ve-LXv76vuBLHQQtREHn_ZogUsbyqzz2-uTHT_Ps-9vS3Pw@mail.gmail.com>
Message-ID: <CAF+7xWnJj4XovwT5K_BDN8Q4GBLogsCb29Ro9t0Taek95HaPDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/18 Bryan Wu <bryan.wu@canonical.com>:
> On Tue, Sep 18, 2012 at 11:30 AM, Axel Lin <axel.lin@gmail.com> wrote:
>> This fixes below build error when CONFIG_LEDS_CLASS is not set.
>>
>>   LD      init/built-in.o
>> arch/arm/plat-omap/built-in.o: In function `fpga_probe':
>> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
>> make: *** [vmlinux] Error 1
>>
>
> Thanks for posting this. But I think Tony has already fixed it in mainline:
> --
> commit 359f64f7b3997e94ee71039b5fcdc1278b9b77c4
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Wed Sep 15 10:18:51 2010 -0700
>
>     omap: Fix compile dependency to LEDS_CLASS
>
>     If we LEDS_CLASS is not selected, we will get undefined reference
>     to `led_classdev_register'.
>
>     Signed-off-by: Tony Lindgren <tony@atomide.com>

Commit 359f64f7b was commited on Sep 15 2010.
This patch is against current linux-next tree.
I got the build error on linux-next tree (next-20120917).

Regards,
Axel
