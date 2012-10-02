From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 02 Oct 2012 14:37:35 -0700
Subject: [PATCH] ARM: OMAP2+: PM: fix return value check in
 omap2_set_init_voltage()
In-Reply-To: <CAORVsuWGPw6Q4Z-nnPqMMBAf=tYXGydHqXSnd-JdXRV9NtGP=A@mail.gmail.com>
 (Jean Pihet's message of "Fri, 28 Sep 2012 12:42:12 +0200")
References: <CAPgLHd-q3rF822NrpJQcMgr2=BNAp=p_rbRdEXp-gSutnjuBFQ@mail.gmail.com>
 <CAORVsuWGPw6Q4Z-nnPqMMBAf=tYXGydHqXSnd-JdXRV9NtGP=A@mail.gmail.com>
Message-ID: <87d3108sio.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Sep 27, 2012 at 7:54 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function voltdm_lookup() returns NULL
>> not ERR_PTR(). The IS_ERR() test in the return value check
>> should be replaced with NULL test.
>>
>> dpatch engine is used to auto generate this patch.
>> (https://github.com/weiyj/dpatch)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  arch/arm/mach-omap2/pm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 9cb5ced..ab15e5c 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -176,7 +176,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>>         }
>>
>>         voltdm = voltdm_lookup(vdd_name);
>> -       if (IS_ERR(voltdm)) {
>> +       if (!voltdm) {
>>                 pr_err("%s: unable to get vdd pointer for vdd_%s\n",
>>                         __func__, vdd_name);
>>                 goto exit;
>
> This looks good, so here is the ack:
> Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks, queuing this one for v3.7-rc.

Kevin
