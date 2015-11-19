From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 19 Nov 2015 16:10:03 +0800
Subject: [PATCH v3 03/12] drm/rockchip: return a true clock rate to
 adjusted_mode
In-Reply-To: <564D756D.9050000@rock-chips.com>
References: <1447904131-29328-1-git-send-email-zyw@rock-chips.com>
 <1447904131-29328-4-git-send-email-zyw@rock-chips.com>
 <564D756D.9050000@rock-chips.com>
Message-ID: <564D83DB.9040705@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/19/2015 03:08 PM, Mark yao wrote:
> On 2015?11?19? 11:35, Chris Zhong wrote:
>> +
>> +    /*
>> +     * Sometimes the clock driver can not set a accurate clock_rate 
>> for vop,
>> +     * get the true rate of vop_dclk and set it back to adjusted_mode.
>> +     */
>> +    adjusted_mode->clock = clk_get_rate(vop->dclk) / 1000;
>>   out:
>>       ret_clk = clk_enable(vop->dclk);
>>       if (ret_clk < 0) {
> Hi Chris
>      How about use clk_round_rate to check the clock rate first?
>      I think we can check it on vop_crtc_mode_fixup.
Hi Mark
     Nice advice, I'll modify it in next version. Thanks.
>
> Thanks.
> - ?ark Yao
>
>
>
