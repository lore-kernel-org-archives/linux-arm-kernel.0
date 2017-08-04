From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Aug 2017 12:29:50 +0800
Subject: [linux-sunxi] [PATCH 10/13] [NOT FOR REVIEW NOW] clk: sunxi: Add
 CLK_SET_RATE_PARENT flag for H3 HDMI clock
In-Reply-To: <55076172-DD11-4AF5-AEAF-A16C757BF5F0@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <20170801131304.7741-11-icenowy@aosc.io>
 <CAGb2v65Ncp5jfq5hrOpqBNYER-VGW1B5j4zT40rj8_CJh5xxVw@mail.gmail.com>
 <55076172-DD11-4AF5-AEAF-A16C757BF5F0@aosc.io>
Message-ID: <CAGb2v67ihCOmjojidpGfp9WvLiWWbwL+27tm7vOrKX0rRH4O1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 12:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?8?4? GMT+08:00 ??12:15:27, Chen-Yu Tsai <wens@csie.org> ??:
>>Hi,
>>
>>On Tue, Aug 1, 2017 at 9:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>> From: Jernej Skrabec <jernej.skrabec@siol.net>
>>>
>>> When setting the HDMI clock of H3, the PLL_VIDEO clock needs to be
>>set.
>>>
>>> Add CLK_SET_RATE_PARENT flag for H3 HDMI clock.
>>>
>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> index b1127e8629d9..2ebb3d865b01 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> @@ -474,7 +474,7 @@ static SUNXI_CCU_GATE(avs_clk,
>>"avs",          "osc24M",
>>>
>>>  static const char * const hdmi_parents[] = { "pll-video" };
>>>  static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
>>> -                                0x150, 0, 4, 24, 2, BIT(31), 0);
>>> +                                0x150, 0, 4, 24, 2, BIT(31),
>>CLK_SET_RATE_PARENT);
>>
>>Line is longer than 80 characters.
>>
>>This looks independent enough so I've merged this for 4.14 with the
>>offending line wrapped and the following tag added:
>>
>>Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
>
> Please don't merge this now until Jernej send it.

(Dropped Rob, devicetree and dri mailing lists)

Hi Jernej,

Is it OK if we take this patch for the next release? Or rather,
if there anything blocking this patch?

Thanks
ChenYu

>
>>
>>ChenYu
>>
>>>
>>>  static SUNXI_CCU_GATE(hdmi_ddc_clk,    "hdmi-ddc",     "osc24M",
>>>                       0x154, BIT(31), 0);
>>> --
>>> 2.13.0
>>>
>>> --
>>> You received this message because you are subscribed to the Google
>>Groups "linux-sunxi" group.
>>> To unsubscribe from this group and stop receiving emails from it,
>>send an email to linux-sunxi+unsubscribe at googlegroups.com.
>>> For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
