From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 5 Apr 2017 19:59:04 +0800
Subject: [linux-sunxi] [PATCH 02/11] arm64: allwinner: a64: add NMI
 controller on A64
In-Reply-To: <20170405072832.qunhfngatebcgn4q@lukather>
References: <20170404180145.12897-1-icenowy@aosc.io>
 <20170404180145.12897-3-icenowy@aosc.io>
 <CAGb2v67BucT8=FTgem3AmSU9XJA7OHoTCq3t3wBzDWyuwzZqaA@mail.gmail.com>
 <20170405061137.n66ectbkl7a2fv5f@lukather>
 <CAGb2v672Z2JedGF3n+8Hi78QG_hAxz0ZYXaCkw0GAkA3xEdKrA@mail.gmail.com>
 <20170405072832.qunhfngatebcgn4q@lukather>
Message-ID: <CAGb2v64zZcxBEGn5KjP3LLNVCfLSN-+BN_51HAA4nAM-nWDWCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 3:28 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Apr 05, 2017 at 02:20:31PM +0800, Chen-Yu Tsai wrote:
>> On Wed, Apr 5, 2017 at 2:11 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Wed, Apr 05, 2017 at 11:51:45AM +0800, Chen-Yu Tsai wrote:
>> >> On Wed, Apr 5, 2017 at 2:01 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> >> > Allwinner A64 SoC features a NMI controller, which is usually connected
>> >> > to the AXP PMIC.
>> >> >
>> >> > Add support for it.
>> >> >
>> >> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >>
>> >> This might not be the best representation of the R_INTC block. Though
>> >> we'd need to change it for all SoCs if we want to be accurate. For now,
>> >
>> > What do you think would be a good representation?
>>
>> My gut feeling is that this is the old INTC from sun4/5i.
>
> Ah, that would make sense.
>
>> It's supposed to be the interrupt controller for the embedded low
>> power core. I've not done a thorough comparison though.
>
> Do we have some documentation / code for this one?

I can't remember where or if I saw any. If Allwinner ever released
any source code for the OpenRISC core we could actually verify it.

However the base address of this block, in addition to the register
offsets found in the driver for "allwinner,sun6i-a31-sc-nmi" do match
up with the sun4i irqchip. The question is if any of the other interrupt
lines are hooked up, and if yes, to what. A possibility would be that
it has all the interrupt lines in the SoC also hooked up, at the same
numbers as the GIC (minus 32). It would feed both the GIC and CPUS.
This is just an educated guess though.

Regards
ChenYu
