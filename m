From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 31 Mar 2016 19:25:35 +0900
Subject: [PATCH 2/2] ARM: uniphier: initialize outer cache for secondary
 CPUs
In-Reply-To: <3226381.VKfgCFa2AC@wuerfel>
References: <201603291505.HKmOMR4P%fengguang.wu@intel.com>
 <3226381.VKfgCFa2AC@wuerfel>
Message-ID: <CAK7LNAS5AE9daz5F8OKAWgPHKGLB-px3-yi-hgSBfjjAUyxYnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2016-03-29 17:11 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 29 March 2016 15:59:00 kbuild test robot wrote:
>>
>> All warnings (new ones prefixed by >>):
>>
>> >> WARNING: vmlinux.o(.text+0x557b4): Section mismatch in reference from the function uniphier_cache_secondary_init() to the function .init.text:uniphier_cache_activate_all_ways()
>>    The function uniphier_cache_secondary_init() references
>>    the function __init uniphier_cache_activate_all_ways().
>>    This is often because uniphier_cache_secondary_init lacks a __init
>>    annotation or the annotation of uniphier_cache_activate_all_ways is wrong.
>>
>
>
> I guess the former: uniphier_cache_secondary_init should be __init, as it will
> only be run at boot time.
>
> Please resend both patches.
>

I think the alternative solution suggested by Russell is much better.

I hope Russell will apply his one, and then I retract this series.



-- 
Best Regards
Masahiro Yamada
