From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 9 Apr 2014 09:17:30 -0700
Subject: Big endian working?
In-Reply-To: <4880190.MJBhke5aDa@wuerfel>
References: <20140408095446.0520dd28@skate>
 <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
 <53450D3A.7030909@linaro.org> <4880190.MJBhke5aDa@wuerfel>
Message-ID: <CAA3XUr2QQy_cy6yP19HWNxCcwPbY9FUi9VAZj7easz+HkLZa+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2014 02:38, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 April 2014 12:04:58 Taras Kondratiuk wrote:
>>
>> > Maybe Nico's zImage change was under atags umbrella by mistake and
>> > it really addresses general zImage issue. In this case we need to add
>> > this commit to main line. However, I don't think we need to carry
>> > CPU_BE8_BOOT_LE option forward, why we just use
>> > CONFIG_CPU_BIG_ENDIAN instead. Note in all cases when BE
>> > image used loader is always in LE mode. Never seen case
>> > otherwise.
>>
>> That makes sense, but I'm concerned about BE32 systems.
>> Do they also have LE bootloaders? I don't remember kernel code which
>> switches to BE32. I'd think that switch is done by bootloader or
>> ROMcode. Or even BE hardwired in HW. So BE32 bootloader may expect to
>> see BE zImage header.
>> Maybe instead of CONFIG_CPU_BIG_ENDIAN use CONFIG_CPU_ENDIAN_BE8?

I doubt that those old bootloaders could handle zImage
and patch under discussion is only about zImage. But
it is fine let's use CONFIG_CPU_ENDIAN_BE8 to be
on conservative side.

Taras, could please change Nico's/Ben's zImage patch
properly and submit it for quick review and further submission
to mainline. It would be good to have zImage load fixed for
big endian.

> Agreed. CONFIG_CPU_ENDIAN_BE32 basically means ixp4xx. Whatever those
> systems do today, I think we should better not change anything
> for them. If nobody has complained for the last 10 years, everyone
> who cares must have already found a working solution by now.
>
> For BE8, I think we should just try to do the right thing before
> we see mass deployments of broken boot loaders.

Agreed. For any BE work we've done it was stated that
it should work with regular LE bootloaders. In fact any system
should be able to switch between LE and BE images without
any other changes, not even bootloader setting or variable.

Thanks,
Victor

>         Arnd
