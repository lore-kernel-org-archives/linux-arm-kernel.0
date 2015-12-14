From: xuejiancheng@huawei.com (xuejiancheng)
Date: Mon, 14 Dec 2015 10:07:43 +0800
Subject: [PATCH v3 3/7] ARM: hisi: add dt_machine definition for Hi3519
In-Reply-To: <20151211152106.GB21272@rob-hp-laptop>
References: <1449819921-18464-1-git-send-email-xuejiancheng@huawei.com>
 <1449819921-18464-4-git-send-email-xuejiancheng@huawei.com>
 <20151211152106.GB21272@rob-hp-laptop>
Message-ID: <566E246F.2050304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/11 23:21, Rob Herring wrote:
> On Fri, Dec 11, 2015 at 03:45:17PM +0800, Jiancheng Xue wrote:
>> add dt_machine definition for hi3519.
>>
>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
>> ---
>>  arch/arm/mach-hisi/hisilicon.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
>> index 8cc6215..010d8a2 100644
>> --- a/arch/arm/mach-hisi/hisilicon.c
>> +++ b/arch/arm/mach-hisi/hisilicon.c
>> @@ -81,3 +81,12 @@ static const char *const hip01_compat[] __initconst = {
>>  DT_MACHINE_START(HIP01, "Hisilicon HIP01 (Flattened Device Tree)")
>>  	.dt_compat      = hip01_compat,
>>  MACHINE_END
>> +
>> +static const char *const hi3519_compat[] __initconst = {
>> +	"hisilicon,hi3519",
>> +	NULL,
>> +};
> 
> You should just have 1 mach desc with multiple compatible strings to 
> match against, not 1 mach desc per compatible string.

Yes, you're right. But Hi3519 is a soc in a new family. It doesn't belong to
any other existing mach descs. And more hi3519 compatible boards will be added
in this mach desc afterwards.
Can I do it like this now, and combine them at a proper time?

Or just add a more generic mach desc, then other socs like hix5hd2/hip01/hip04 can use this?
static const char *const hisilicon_compat[] __initconst = {
        "hisilicon,hi3519",
        NULL,
};

DT_MACHINE_START(HISILICON_DT, "Hisilicon")
        .dt_compat      = hisilicon_compat,
MACHINE_END



> Rob
> 
>> +
>> +DT_MACHINE_START(HI3519_DT, "Hisilicon Hi3519")
>> +	.dt_compat	= hi3519_compat,
>> +MACHINE_END
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
