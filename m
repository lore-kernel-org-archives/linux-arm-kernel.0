From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 04 Jun 2012 14:23:49 +0530
Subject: [RFC 11/24] ARM: omap: clk: list all clk_hw_omap clks to
 enable/disable autoidle
In-Reply-To: <20120604054417.GU12766@atomide.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
 <1338552485-31325-12-git-send-email-rnayak@ti.com>
 <20120604054417.GU12766@atomide.com>
Message-ID: <4FCC779D.7010208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Monday 04 June 2012 11:14 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120601 05:12]:
>> @@ -359,6 +391,8 @@ const struct clk_hw_omap_ops clkhwops_wait = {
>>   	.find_idlest	= omap2_clk_dflt_find_idlest,
>>   	.find_companion	= omap2_clk_dflt_find_companion,
>>   };
>> +late_initcall(omap2_clk_enable_autoidle_all);
>
> With -rc1, the SoC specific late_initcalls need to be called from
> *_init_late that are in mach-omap2/io.c for omap2+.

Thanks for the heads-up. Will take care of it while I move over to
3.5-rc1.

thanks,
Rajendra

>
> Regards,
>
> Tony
