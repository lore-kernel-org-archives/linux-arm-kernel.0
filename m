From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 21 May 2010 12:16:26 +0200
Subject: [PATCH 07/22] OMAP: hwmod: Replace WARN by pr_warning if clock
	lookup	failed
In-Reply-To: <4BF659CB.6010605@ru.mvista.com>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
	<20100519021845.19716.65638.stgit@localhost.localdomain>
	<4BF659CB.6010605@ru.mvista.com>
Message-ID: <4BF65D7A.7070605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/21/2010 12:00 PM, Sergei Shtylyov wrote:
> Hello.
>
> Paul Walmsley wrote:
>> From: Benoit Cousson<b-cousson@ti.com>
>
>> The WARN is a little bit too verbose and is not providing
>> usefull information in that case.
>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Paul Walmsley<paul@pwsan.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index a62920b..5d3a3ea 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -411,9 +411,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
>>   		return 0;
>>
>>   	c = omap_clk_get_by_name(oh->main_clk);
>> -	WARN(!c, "omap_hwmod: %s: cannot clk_get main_clk %s\n",
>> -	     oh->name, oh->main_clk);
>>   	if (!c)
>> +		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
>> +			   oh->name, oh->main_clk);
>>   		ret = -EINVAL;
>
>      Don't you need {} around the statements here?

You don't like the Python style for managing block? :-)
In that case, it is indeed better to have that.
I'll fix that one and the following ones.

Thanks,
Benoit
