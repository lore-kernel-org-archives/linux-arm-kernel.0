From: gerg@uclinux.org (Greg Ungerer)
Date: Thu, 8 Dec 2016 00:34:44 +1000
Subject: [PATCH 4/4] ARM: versatile: support configuring versatile machine
 for no-MMU
In-Reply-To: <CACRpkdZywn46QbnvKcN-jkt43Vf+GBSNQkLgnnNg-DC-8aSO5w@mail.gmail.com>
References: <1481093992-30520-1-git-send-email-gerg@uclinux.org>
 <1481093992-30520-2-git-send-email-gerg@uclinux.org>
 <CACRpkdZywn46QbnvKcN-jkt43Vf+GBSNQkLgnnNg-DC-8aSO5w@mail.gmail.com>
Message-ID: <d64c0ccc-8db9-a565-7415-7108965a0e0e@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 08/12/16 00:11, Linus Walleij wrote:
> On Wed, Dec 7, 2016 at 7:59 AM, Greg Ungerer <gerg@uclinux.org> wrote:
>
>> The motivation for this is that the versatile machine is well supported
>> in qemu. And this provides an excellent platform for development and
>> testing no-MMU support on ARM in general.
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>
> Pretty cool eh?

Yep :-)


> Have you tested it on real hardware?

No, I don't have a Versatile board, or access to one...


> Otherwise I can test it if I have a git branch
> I can pull in and compile.

I have been stashing the changes here for now:

git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git

in the armnommu branch.


> Another target I had in mind was the Integrator which
> incidentally supports a bunch of the old noMMU core
> tiles where we can swap in an ARM946, which I guess
> could work with this?

It should do, or at least should be able to be made to work with it.


>> --- a/arch/arm/mach-versatile/Kconfig
>> +++ b/arch/arm/mach-versatile/Kconfig
>> @@ -1,12 +1,13 @@
>>  config ARCH_VERSATILE
>>         bool "ARM Ltd. Versatile family"
>> -       depends on ARCH_MULTI_V5
>> +       depends on ARCH_MULTI_V5 || ARM_SINGLE_ARMV5
>>         select ARM_AMBA
>>         select ARM_TIMER_SP804
>>         select ARM_VIC
>>         select CLKSRC_VERSATILE
>>         select COMMON_CLK_VERSATILE
>>         select CPU_ARM926T
>> +       select GPIOLIB
>
> Not really related but I don't mind.

No, probably strictly not. But without this here we lose CONFIG_GPIO
for the no-MMU case. When CONFIG_MMU was enabled it was being selected
via some other path through arch/arm/Kconfig - I don't recall at the
moment where exactly.


> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks
Greg
