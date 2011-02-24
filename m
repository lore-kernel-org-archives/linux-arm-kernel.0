From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Thu, 24 Feb 2011 15:57:35 +0530
Subject: [PATCH 1/1] da830: macro rename DA8XX_LPSC0_DMAX to
	DA8XX_LPSC0_PRUSS.
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BE4916D@dbde02.ent.ti.com>
References: <1297433905-27925-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BE4916D@dbde02.ent.ti.com>
Message-ID: <B078763F059B415E9DD8D61AA14F9D5C@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Subhasish,
>
> Please add a "davinci: " prefix to the subject line of
> mach-davinci patches. The patch is not really specific
> to DA830.

SG -- OK, Will do

>
> On Fri, Feb 11, 2011 at 19:48:25, Subhasish Ghosh wrote:
>> The PRUSS was named as DMAX on da830 platform.
>> This patch resolves the naming conflict by replacing the macro
>> DA8XX_LPSC0_DMAX with DA8XX_LPSC0_PRUSS.
>
> This description is inaccurate. Firstly, there is no naming
> conflict. DMAX is an internal name for the module which is
> known as PRUSS in TI public documentation. This patch just
> gets the code in sync with TI documentation.
>
> Can you please update the subject and re-spin this patch?

SG - OK, Will do.


>
> Thanks,
> Sekhar
>
>>
>> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
>> ---
>>  arch/arm/mach-davinci/da830.c            |    2 +-
>>  arch/arm/mach-davinci/include/mach/psc.h |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/da830.c 
>> b/arch/arm/mach-davinci/da830.c
>> index ec23ab4..0577a5d 100644
>> --- a/arch/arm/mach-davinci/da830.c
>> +++ b/arch/arm/mach-davinci/da830.c
>> @@ -148,7 +148,7 @@ static struct clk scr2_ss_clk = {
>>  static struct clk dmax_clk = {
>>  .name = "dmax",
>>  .parent = &pll0_sysclk2,
>> - .lpsc = DA8XX_LPSC0_DMAX,
>> + .lpsc = DA8XX_LPSC0_PRUSS,
>>  .flags = ALWAYS_ENABLED,
>>  };
>>
>> diff --git a/arch/arm/mach-davinci/include/mach/psc.h 
>> b/arch/arm/mach-davinci/include/mach/psc.h
>> index 62b0858..a47e6f2 100644
>> --- a/arch/arm/mach-davinci/include/mach/psc.h
>> +++ b/arch/arm/mach-davinci/include/mach/psc.h
>> @@ -150,7 +150,7 @@
>>  #define DA8XX_LPSC0_SCR0_SS 10
>>  #define DA8XX_LPSC0_SCR1_SS 11
>>  #define DA8XX_LPSC0_SCR2_SS 12
>> -#define DA8XX_LPSC0_DMAX 13
>> +#define DA8XX_LPSC0_PRUSS 13
>>  #define DA8XX_LPSC0_ARM 14
>>  #define DA8XX_LPSC0_GEM 15
>>
>> -- 
>> 1.7.2.3
>>
>>
> 
