From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Mon, 19 Jul 2010 17:09:28 +0900
Subject: [PATCH v3 1/7] ARM: S5PV210: Add a Kconfig entry
	"S5PC110_EVT0_WORKAROUND"
In-Reply-To: <002c01cb2718$46fcc4a0$d4f64de0$%kim@samsung.com>
References: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-2-git-send-email-myungjoo.ham@samsung.com>
	<002c01cb2718$46fcc4a0$d4f64de0$%kim@samsung.com>
Message-ID: <AANLkTim9UtCiyqhLRRWw42WyzgwjTY1OGbsPTwGJKn7p@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 4:59 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> Early S5PC110 (EVT0) chip had some issues required workaround from a
>> kernel. We can add such workaround codes with this Kconfig entry.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/Kconfig | ? ?7 +++++++
>> ?1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
>> index 631019a..18802e7 100644
>> --- a/arch/arm/mach-s5pv210/Kconfig
>> +++ b/arch/arm/mach-s5pv210/Kconfig
>> @@ -101,4 +101,11 @@ config MACH_SMDKC110
>> ? ? ? ? Machine support for Samsung SMDKC110
>> ? ? ? ? S5PC110(MCP) is one of package option of S5PV210
>>
>> +config S5PC110_EVT0_WORKAROUND
>> + ? ? bool "S5PC110 Early Chip Workaround (EVT0)"
>> + ? ? help
>> + ? ? ? Early S5PC110 (so called EVT0) has errata items that should be
>> + ? ? ? addressed; otherwise the kernel may panic or be locked up. Enable
>> + ? ? ? this option to execute workaround instructions.
>> +
>> ?endif
>> --
>
> As I said earlier, EVT0 is not real chip and not for mass production.
>
> Why do you submit the EVT0 patch which can only available for you?
> It is better to not add code into mainline that is not going to be used.

Did you read the previous mail? I explain that.
The LSI focus the latest SoCs. but we got the early chip and used it.
You see the chip itself but I see the product which used the chips
whether for mass production or not.

Actually it's management and maintenance problem. you only show the
latest codes and chips to outside.
but I want to maintain our board at mainline.

Thank you,
Kyungmin Park
