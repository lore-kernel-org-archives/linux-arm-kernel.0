From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Sun, 4 Nov 2018 23:39:44 +0800
Subject: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <154130064120.88331.5081431734592584205@swboyd.mtv.corp.google.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <ca95948abd58876a23b2eb3e52b96124e9eed793.camel@baylibre.com>
 <20181024145513.GA6647@ofant>
 <154130064120.88331.5081431734592584205@swboyd.mtv.corp.google.com>
Message-ID: <fe4b3d70-12ae-84ae-0451-f5d67aa99fcd@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen,

Thank you for the review.

On 2018/11/4 11:04, Stephen Boyd wrote:
> Quoting Yixun Lan (2018-10-25 00:29:15)
>> yes, I think the documentation need to be fixed
>>
>> for the final solution, we decide to make 'mmc-clkc' an independent node
>> instead of being a sub-node of 'mmc', so both of them may exist in parallel..
>>
>> the DT part may like this:
>>
>>                         sd_emmc_c_clkc: clock-controller at 7000 {
>>                                 compatible = "amlogic,axg-mmc-clkc", "syscon";
>>                                 reg = <0x0 0x7000 0x0 0x4>;
>>                                 ...
>>                         };
>>
>>                         sd_emmc_c: mmc at 7000 {
>>                                 compatible = "amlogic,axg-mmc";
>>                                 reg = <0x0 0x7000 0x0 0x800>;
>>                                 ...
>>                         };
> 
> That's improper usage of DT. We don't want two devices at the same
> register offset.
sd_emmc_c_clkc is shared by nand and sd_emmc_c controller, and this clock is part of the MMC controller's register space.
 
The idea of adding the clock-controller at 7000is introduced during the discussion in the NAND driver mainline effort:
https://lkml.kernel.org/r/20180628090034.0637a062 at xps13
> 
> .
> 
