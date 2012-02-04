From: olof@lixom.net (Olof Johansson)
Date: Sat, 4 Feb 2012 11:30:32 -0800
Subject: [PATCH] arm: fix build failure in mach-bcmring/arch.c
In-Reply-To: <4F1E00BB.9070705@broadcom.com>
References: <1327263990-8769-1-git-send-email-paul.gortmaker@windriver.com>
 <4F1E00BB.9070705@broadcom.com>
Message-ID: <CAOesGMj9nRAXLwn+B7W_A4eOwwZJBHLiyHUKhC+T1ty4To5D7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 4:52 PM, Jiandong Zheng <jdzheng@broadcom.com> wrote:
> On 1/22/2012 12:26 PM, Paul Gortmaker wrote:
>>
>> Upstream commit d1fce9c115eeb93e01c01732dfe9a86cf76009cf
>>
>> ? ? "ARM: restart: bcmring: use new restart hook"
>>
>> breaks building of this platform, since what used to be the
>> last field of the MACHINE_START/END block didn't have a
>> trailing comma. ?Once another field was added below, we get:
>>
>> arch/arm/mach-bcmring/arch.c:198: error: request for member 'restart' in
>> something not a structure or union
>>
>> Signed-off-by: Paul Gortmaker<paul.gortmaker@windriver.com>
>>
>> diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
>> index 9e5e755..45c97b1 100644
>> --- a/arch/arm/mach-bcmring/arch.c
>> +++ b/arch/arm/mach-bcmring/arch.c
>> @@ -194,6 +194,6 @@ MACHINE_START(BCMRING, "BCMRING")
>> ? ? ? ?.init_early = bcmring_init_early,
>> ? ? ? ?.init_irq = bcmring_init_irq,
>> ? ? ? ?.timer =&bcmring_timer,
>> - ? ? ? .init_machine = bcmring_init_machine
>> + ? ? ? .init_machine = bcmring_init_machine,
>> ? ? ? ?.restart = bcmring_restart,
>> ?MACHINE_END
>
>
> Acked-by: Jiandong Zheng <jdzheng@broadcom.com>

Thanks, applied to arm-soc fixes for -rc.


-Olof
