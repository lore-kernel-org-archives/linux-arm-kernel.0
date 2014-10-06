From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 06 Oct 2014 11:34:27 +0200
Subject: [PATCH 3/4] [media] Remove optional dependency on PLAT_S5P
In-Reply-To: <4788945.SoI4OqN9Zu@wuerfel>
References: <1412586626.4054.42.camel@x220> <4788945.SoI4OqN9Zu@wuerfel>
Message-ID: <54326223.3050201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/14 11:26, Arnd Bergmann wrote:
> On Monday 06 October 2014 11:10:26 Paul Bolle wrote:
>>  config VIDEO_SAMSUNG_S5P_TV
>>         bool "Samsung TV driver for S5P platform"
>>         depends on PM_RUNTIME
>> -       depends on PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST
>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>>         default n
>>         ---help---
>>           Say Y here to enable selecting the TV output devices for
>>
> 
> I wonder if it should now allow being built for ARCH_S5PV210.
> Maybe it was a mistake to remove the PLAT_S5P symbol without changing
> the use here?
> 
> Does S5PV210 have this device?

Yes, it does. Indeed, in all patches in this series we should
have replaced PLAT_S5P with ARCH_S5PV210.

--
Thanks,
Sylwester
