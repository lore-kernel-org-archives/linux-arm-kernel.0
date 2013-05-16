From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 May 2013 17:20:36 +0200
Subject: [PATCH 0/4] ARM: Remove boilerplate debug_ll_io_init code
In-Reply-To: <201305160040.54399.arnd@arndb.de>
References: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
 <201305160040.54399.arnd@arndb.de>
Message-ID: <5194F944.2040803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Le 16/05/2013 00:40, Arnd Bergmann a ?crit :
> On Monday 13 May 2013, Maxime Ripard wrote:
>> The recent introduction of debug_ll_io_init made possible to not rely
>> anymore on a custom map_io function but on debug_ll_io_init for the
>> early mapping and then on the various drivers to do the needed mappings for
>> the kernel to boot.
>>
>> Some architectures begin to use only this function as the map_io callback in
>> the machine description.
>>
>> In order to remove some boilerplate code, make the ARM mm code call
>> debug_ll_io_init by itself when no .map_io callback is defined.
>>
>> This has been tested on the sunxi platform.
> 
> Great stuff!
> 
> I didn't notice the addition of debug_ll_io_init, so this is a nice surprise
> for me.

Well, you can thank Rob for that, I wasn't involved in it in the first
place :)

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks,

How will we merge this? The first patch would be merged by Russel and
the 3 others by their respective maintainers?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
