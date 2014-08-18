From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 18 Aug 2014 23:57:06 +0800
Subject: [linux-sunxi] Re: [PATCH 11/12] ARM: dts: sun8i: Add i2c
 controller nodes
In-Reply-To: <20140818142737.GC15297@lukather>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
 <1408247538-16950-12-git-send-email-wens@csie.org>
 <20140817080204.GY15297@lukather>
 <CAGb2v67NwsJORoFrgEECDtexXGtF5qOx7NX1PVpZHkjVs-mG2A@mail.gmail.com>
 <20140818142737.GC15297@lukather>
Message-ID: <CAGb2v65ODS83D2LfiHs0o1D4yJ6xmOJ8vULPcfrcUu79SQvfTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:27 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, Aug 17, 2014 at 11:20:44PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Sun, Aug 17, 2014 at 4:02 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Sun, Aug 17, 2014 at 11:52:17AM +0800, Chen-Yu Tsai wrote:
>> >> Add nodes for the 3 i2c controllers found on A23 SoCs to the sun8i DTSI.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> ---
>> >>  arch/arm/boot/dts/sun8i-a23.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 36 insertions(+)
>> >>
>> >> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
>> >> index 4658998..53ef350 100644
>> >> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
>> >> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
>> >> @@ -387,6 +387,42 @@
>> >>                       status = "disabled";
>> >>               };
>> >>
>> >> +             i2c0: i2c at 01c2ac00 {
>> >> +                     compatible = "allwinner,sun6i-a31-i2c";
>> >> +                     reg = <0x01c2ac00 0x400>;
>> >> +                     interrupts = <0 6 4>;
>> >> +                     clocks = <&apb2_gates 0>;
>> >> +                     clock-frequency = <100000>;
>> >
>> > It's the default, you don't need to set it.
>>
>> Ah, just checked the driver, it is indeed the default.
>> All the other sunxi dtsi have it though. Do we want to be consistent?
>
> Yep, it's usually a good thing :)

I'll do additional patches to remove them from the other dtsi then.
