From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 12:42:44 -0700
Subject: [PATCH v5 01/10] clk: mediatek: Removed unused dpi_ck clock from
 MT8173
In-Reply-To: <1450634.BBmUdb8ZLk@diego>
References: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438154233.17770.39.camel@mtksdaap41> <20150730173643.GH3159@codeaurora.org>
 <1450634.BBmUdb8ZLk@diego>
Message-ID: <55BA7E34.2050206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2015 11:04 AM, Heiko St?bner wrote:
> Am Donnerstag, 30. Juli 2015, 10:36:43 schrieb Stephen Boyd:
>
>> Is it being used in DT right now and causing regressions on
>> v4.2-rcX? Sorry, I'm trying to understand why this patch matters
>> for the 4.2 release.
> it's not been used in an actual devicetree file, but as far as I understand it,
> the dt-binding headers themself are also part of the ABI.
>
> And it is new in 4.2, so has not been part of an official release yet.
>
> The reason for the removal from what I understand is that the removed clock is
> not documented at all (it's source, what it does), which got it the "clk_null"
> parent in the first place.
>
>

Right, so my understanding of the DT ABI thing is that newer kernels 
should keep working with older DTs. If there isn't any DT using the 
binding, then we don't have a problem because the only thing that could 
happen would be a newer DT working with an older kernel, which doesn't 
make any sense from a backwards incompatible standpoint.

If you feel strongly that some sort of DT ABI rule would be broken and 
you want to make sure that doesn't happen I guess we can queue this up 
to be sent off to Linus, but if you aren't worried (and I'm obviously 
not worried) then I'd prefer we just queue it up for 4.3.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
