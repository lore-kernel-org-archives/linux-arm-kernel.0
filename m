From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 29 Nov 2010 15:57:18 +0900
Subject: [PATCH 9/9] ARM: S5PV310: Add audio platform devices
In-Reply-To: <000201cb8f92$0abbd430$20337c90$%szyprowski@samsung.com>
References: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
	<1290072077-17573-1-git-send-email-jassisinghbrar@gmail.com>
	<000201cb8f92$0abbd430$20337c90$%szyprowski@samsung.com>
Message-ID: <AANLkTik6bNPuD8gQ35w57h8bhO-nFCK+OROt-8BH=8Wt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 3:52 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Thursday, November 18, 2010 10:21 AM Jassi Brar wrote:
>
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> Define platform devices for all audio devices found on S5PV310
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-s5pv310/dev-audio.c ? ? ? ? | ?364 +++++++++++++++++++++++++++++
>> ?arch/arm/mach-s5pv310/include/mach/map.h ?| ? 16 ++
>> ?arch/arm/plat-samsung/include/plat/devs.h | ? ?9 +
>> ?4 files changed, 390 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-s5pv310/dev-audio.c
>>
>> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
>> index d265adb..61e3cb6 100644
>> --- a/arch/arm/mach-s5pv310/Makefile
>> +++ b/arch/arm/mach-s5pv310/Makefile
>> @@ -27,6 +27,7 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210) ? += mach-universal_c210.o
>>
>> ?# device support
>>
>> +obj-y += dev-audio.o
>
> Why do you compile in audio support unconditionally? All other devices have the
> respective Kconfig entry, so please add one for audio and use it. We really don't
> want to have all devices compiled into the kernel all the times for all the boards.

It was decided by Ben (and Mark IIRC) that most, if not all, devices use
audio and it is better to have the platform support built unconditionally.
If you see, it is same for all platforms since 64xx.
