From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 17 Apr 2014 19:15:09 +0900
Subject: [PATCHv2 5/8] ARM: EXYNOS: Support secondary CPU boot of
 Exynos3250
In-Reply-To: <CAHbNUh3m7n1OT9fc715vth=k6BdAvVZoYJjBvo8xT25TPji18w@mail.gmail.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-6-git-send-email-cw00.choi@samsung.com>
 <CAHbNUh3m7n1OT9fc715vth=k6BdAvVZoYJjBvo8xT25TPji18w@mail.gmail.com>
Message-ID: <534FA9AD.7000406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On 04/15/2014 02:09 PM, Tushar Behera wrote:
> On 15 April 2014 07:29, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch fix the offset of CPU boot address and don't operate smc call
>> of SMC_CMD_CPU1BOOT command for Exynos3250.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/firmware.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
>> index aa01c42..6205d4f 100644
>> --- a/arch/arm/mach-exynos/firmware.c
>> +++ b/arch/arm/mach-exynos/firmware.c
>> @@ -30,13 +30,16 @@ static int exynos_do_idle(void)
>>
>>  static int exynos_cpu_boot(int cpu)
>>  {
>> +       if (soc_is_exynos3250()) {
>> +               return 0;
>>         /*
>>          * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
>>          * But, Exynos4212 has only one secondary CPU so second parameter
>>          * isn't used for informing secure firmware about CPU id.
>>          */
>> -       if (soc_is_exynos4212())
>> +       } else if (soc_is_exynos4212()) {
>>                 cpu = 0;
>> +       }
>>
> 
> As you already return in case of Exynos3250, you need not change this.
> First commit hunk without the opening brace should be sufficient.

OK, I'll remove brace.

Best Regards,
Chanwoo Choi
