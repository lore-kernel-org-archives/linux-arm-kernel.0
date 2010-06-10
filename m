From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 10 Jun 2010 17:45:53 +0800
Subject: [PATCH 3/5] [ARM] Make TEXT_OFFSET a configurable option
In-Reply-To: <20100610085053.GC3422@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-4-git-send-email-eric.miao@canonical.com>
	<20100610085053.GC3422@pengutronix.de>
Message-ID: <AANLkTilNMqC0q65GzRiyyX091390TaHFD7ffaxkWWyf8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Thu, Jun 03, 2010 at 03:36:51PM +0800, Eric Miao wrote:
>> From: Eric Miao <eric.y.miao@gmail.com>
>>
>> Signed-off-by: Eric Miao <eric.miao@canonical.com>
>> ---
>> ?arch/arm/Kconfig ? ? ? ? | ? 13 +++++++++++++
>> ?arch/arm/Makefile ? ? ? ?| ? 13 +------------
>> ?arch/arm/kernel/Makefile | ? ?4 ++--
>> ?3 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 1f254bd..e340193 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1484,6 +1484,19 @@ config ATAGS_PROC
>> ? ? ? ? Should the atags used to boot the kernel be exported in an "atags"
>> ? ? ? ? file in procfs. Useful with kexec.
>>
>> +config TEXT_OFFSET
>> + ? ? hex "Offset of the kernel image from the start of RAM"
> IMHO this should not be user configurable.
>

That's true. The reason I don't want to keep this in Makefile is the
concern about future change to Makefile (that machine-y could be
composed of all the mach-*), and make it a kernel config option at
least provide a way to fix that by the user interactively.

>>

... snip

>> -CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
>> -AFLAGS_head.o ? ? ? ?:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>> +CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(CONFIG_TEXT_OFFSET)
>> +AFLAGS_head.o ? ? ? ?:= -DTEXT_OFFSET=$(CONFIG_TEXT_OFFSET)
> Why not use CONFIG_TEXT_OFFSET directly in head.S?
> Is CONFIG_TEXT_OFFSET available in vmlinux.lds?

I think so, and I'm fine to either way.
