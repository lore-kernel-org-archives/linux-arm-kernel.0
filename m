From: eric.miao@canonical.com (Eric Miao)
Date: Mon, 21 Jun 2010 09:06:33 +0800
Subject: [PATCH 2/2] [ARM] pxa: make use of 'struct machine_class'
In-Reply-To: <20100620180817.2de11de2.ospite@studenti.unina.it>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
	<1277042450-30382-2-git-send-email-eric.miao@canonical.com>
	<20100620180817.2de11de2.ospite@studenti.unina.it>
Message-ID: <AANLkTiklVdwCrys88T-Qy6pvFQ1Y-V7oM6IHjyznyhGX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 12:08 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Sun, 20 Jun 2010 22:00:50 +0800
> Eric Miao <eric.miao@canonical.com> wrote:
>
>> From: Eric Miao <eric.y.miao@gmail.com>
>>
>> Signed-off-by: Eric Miao <eric.miao@canonical.com>
>> ---
>> ?arch/arm/mach-pxa/ezx.c ? ? ?| ? 60 ++++-------------------------------------
>
> The ezx part looks OK. A comment about magician below.
>
> [...]
>> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
>> index e81dd0c..6a86f22 100644
>> --- a/arch/arm/mach-pxa/magician.c
>> +++ b/arch/arm/mach-pxa/magician.c
>> @@ -764,11 +764,6 @@ static void __init magician_init(void)
>>
>>
>> ?MACHINE_START(MAGICIAN, "HTC Magician")
>> - ? ? .phys_io = 0x40000000,
>> - ? ? .io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
>> - ? ? .boot_params = 0xa0000100,
>> - ? ? .map_io = pxa_map_io,
>> - ? ? .init_irq = pxa27x_init_irq,
>> - ? ? .init_machine = magician_init,
>> - ? ? .timer = &pxa_timer,
>> + ? ? .class ? ? ? ? ?= &machine_class_pxa27x,
>> + ? ? .init_machine ? = magician_init,
>> ?MACHINE_END
>
> Magician can use PXA27X_MACHINE() as well, can't it?

Yes, it can. Missed that :-)
