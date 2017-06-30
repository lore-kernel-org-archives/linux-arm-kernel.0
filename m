From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Fri, 30 Jun 2017 15:37:29 +0800
Subject: [PATCH V1 9/9] arm64: dts: add ccu for SC9860
In-Reply-To: <20170630005708.GI22780@codeaurora.org>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-10-chunyan.zhang@spreadtrum.com>
 <20170620012411.GF4493@codeaurora.org>
 <CAAfSe-tBtcsyocumaDAyUP674ey1z+xmfAOR7cqnakM_+MOtfQ@mail.gmail.com>
 <20170630005708.GI22780@codeaurora.org>
Message-ID: <CAAfSe-vsj8SsdB+kVOyNLALM8SkS5KJKbeDN6CHHWL4SjdrbdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your every so clear and detailed answer, thank you.

On 30 June 2017 at 08:57, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/22, Chunyan Zhang wrote:
>> Hi Stephen,
>>
>> On 20 June 2017 at 09:24, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 06/18, Chunyan Zhang wrote:
>>
>> >
>> >> +             compatible = "sprd,sc9860-ccu";
>> >> +             #clock-cells = <1>;
>> >> +             reg = <0 0x20000000 0 0x400>,
>> >> +                   <0 0x20210000 0 0x3000>,
>> >> +                   <0 0x402b0000 0 0x4000>,
>> >> +                   <0 0x402d0000 0 0x400>,
>> >> +                   <0 0x402e0000 0 0x4000>,
>> >> +                   <0 0x40400000 0 0x400>,
>> >> +                   <0 0x40880000 0 0x400>,
>> >> +                   <0 0x415e0000 0 0x400>,
>> >> +                   <0 0x60200000 0 0x400>,
>> >> +                   <0 0x61000000 0 0x400>,
>> >> +                   <0 0x61100000 0 0x3000>,
>> >> +                   <0 0x62000000 0 0x4000>,
>> >> +                   <0 0x62100000 0 0x4000>,
>> >> +                   <0 0x63000000 0 0x400>,
>> >> +                   <0 0x63100000 0 0x3000>,
>> >> +                   <0 0x70b00000 0 0x3000>;
>> >
>> > There are a lot of reg properties here. Perhaps there needs to be
>> > different nodes for the different clock controllers in this SoC?
>> >
>>
>> On Spreadtrum's platform, clocks are basically located in a few
>> address areas due to some hardware design issue, that says there're
>> more than one kinds of clocks in one address range, and one kind of
>> clocks have more than one physical address bases, except ccu_pll and
>> ccu_div in this patchset.
>>
>> We're planning to map the whole device area at one time before
>> initializing each of them, once that has been done and upstreamed, I
>> will remove these lists of addressed.
>
> Ok. Does this mean we need to wait for those patches to be sent

I don't think that would come out for review in the near future, so I
have to keep these ranges of the address listed here for the time
being.

> out for review? Is it more like certain clks are embedded inside
> other devices like display controllers, i2c controllers, etc? Is

>From what I understand, that's just something like you said.

> there any more information I can get on this SoC?

I think you may get more information from our dts files [1], if you
would like to :)


Thanks again,
Chunyan

[1] https://github.com/sprdlinux/kernel/blob/sp9860g-1h10/arch/arm64/boot/dts/sprd/whale.dtsi

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
