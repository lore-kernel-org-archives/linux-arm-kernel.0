From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 7 Jun 2013 23:21:00 +0800
Subject: [PATCH v2 1/8] clk: flag to use upper half of the register as
 change indicator
In-Reply-To: <201306071427.20512.heiko@sntech.de>
References: <201306062107.58875.heiko@sntech.de>
 <201306062108.38587.heiko@sntech.de>
 <CACRpkda+QwnhCHBhQ3d-zUE9dD75Rv0_qt02h6prrzCBzNm5zw@mail.gmail.com>
 <201306071427.20512.heiko@sntech.de>
Message-ID: <CAD6h2NRBHh-4XNnDvyWmVPSpLzLCG32=xuwGZg4nu+WAD6r=Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2013 20:27, Heiko St?bner <heiko@sntech.de> wrote:
> Am Freitag, 7. Juni 2013, 13:46:32 schrieb Linus Walleij:
>> On Thu, Jun 6, 2013 at 9:08 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> > There exist platforms, namely at least all Rockchip Cortex-A9 based ones,
>> > that don't use the paradigm of reading-changing-writing the register
>> > contents, but instead only write the changes to the register with a mask
>> > that indicates the changed bits.
>> >
>> > This patch adds flags and code to support the case where the lower 16 bit
>> > of hold the information and the upper 16 bit are used as mask to
>> > indicate the written changes.
>> >
>> > As hardware-specific flags should not be added to the common clk flags,
>> > the flags are added to gate, mux and divider clocks individually.
>> >
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> (...)
>>
>> > +       if ((clk_gate_flags & CLK_GATE_MASK_UPPER_HALF) && bit_idx > 15)
>> > { +               pr_err("%s: bit_idx %d invalid\n", __func__, bit_idx);
>> > +               return ERR_PTR(-EINVAL);
>> > +       }
>>
>> Now this looks *EXTREMELY* familiar to a patch just sent by Haojian
>> for HiSilicon.
>>
>> "[PATCH v2 3/6] clk: divider: add CLK_DIVIDER_HIWORD_MASK flag"
>> http://marc.info/?l=linux-arm-kernel&m=137035873916777&w=2
>>
>> What kind of coincidence is this? Are Rockchip and HiSilicon using
>> the same silicon IP or are they of a common origin? (It is a small
>> world after all.)
>
> Now this is really interesting :-) and the handling really seems to follow the
> same pattern.
>
>
>> I think you two guys need to read each others patch sets closely
>> here. I'd like Haojian to look at Heiko's patches and Heiko to look
>> at Haojian's patches, just to make sure you're not actually writing
>> two drivers for the same hardware in the end.
>
> I'll take a look
>
>
> Heiko

Me too :)

Regards
Haojian
