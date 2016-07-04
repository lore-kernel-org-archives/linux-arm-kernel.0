From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 4 Jul 2016 12:17:57 +0300
Subject: [PATCH 2/5] ARM: OMAP2+: hwmod: fetch main_clk based on hwmod name
In-Reply-To: <20160704065428.GS28140@atomide.com>
References: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
 <1467292503-4376-3-git-send-email-t-kristo@ti.com>
 <20160704065428.GS28140@atomide.com>
Message-ID: <577A29C5.3010209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/16 09:54, Tony Lindgren wrote:
> Hi,
>
> * Tero Kristo <t-kristo@ti.com> [160630 06:18]:
>> With the transition to hwmod module clocks, all hwmods will have
>> their main clocks named <hwmod_name>_mod_ck. Use this info to
>> fetch main_clk, and use it if found.
> ..
>
>>   static int _init_main_clk(struct omap_hwmod *oh)
>>   {
>>   	int ret = 0;
>> +	char name[32];
>> +	static int max_len;
>> +	struct clk *clk;
>>
>> -	if (!oh->main_clk)
>> -		return 0;
>> +	strcpy(name, oh->name);
>> +	strcat(name, "_mod_ck");
>> +
>> +	if (strlen(name) > max_len)
>> +		max_len = strlen(name);
>
> Just noticed that this needs some improvments to avoid nasty
> bugs early on. You don't seem to have max_len defined, and
> you should do a strncpy using #define MOD_CLK_MAX_LEN (32 + 7)
> or something similar instead of the strcpy and leave room for
> the strcat.
>
> Care to update and repost just this one?

Yeah, let me fix this and repost a bit later today.

-Tero
