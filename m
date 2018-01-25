From: codekipper@gmail.com (Code Kipper)
Date: Thu, 25 Jan 2018 10:07:45 +0100
Subject: [linux-sunxi][PATCH 5/5] arm64: allwinner: a64: Add DAI nodes
In-Reply-To: <20180125082904.t4sqob626kyzw4ga@flea.lan>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-6-codekipper@gmail.com>
 <20180124110222.cdglyg5m7644xiem@flea.lan>
 <CAEKpxBk8NXJn4KxEGXx7UddqpUMC65kdEgx1phZDWyUd3ER_3Q@mail.gmail.com>
 <20180125082904.t4sqob626kyzw4ga@flea.lan>
Message-ID: <CAEKpxBmbz-dwF77PDs-mREHwDfXG3juXz7zUKcaMQKjz=1b+Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 January 2018 at 09:29, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jan 24, 2018 at 12:39:31PM +0100, Code Kipper wrote:
>> On 24 January 2018 at 12:02, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Wed, Jan 24, 2018 at 11:39:43AM +0100, codekipper at gmail.com wrote:
>> >> From: Marcus Cooper <codekipper@gmail.com>
>> >>
>> >> Add the DAI blocks to the device tree. I2S0 and I2S1 are for
>> >> connecting to an external codec.
>> >>
>> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> >> ---
>> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 ++++++++++++++++++++++++++
>> >>  1 file changed, 26 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> index f060a58f374c..f3354f8c2026 100644
>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> @@ -419,6 +419,32 @@
>> >>                       status = "disabled";
>> >>               };
>> >>
>> >> +             i2s0: i2s at 1c22000 {
>> >> +                     #sound-dai-cells = <0>;
>> >> +                     compatible = "allwinner,sun8i-h3-i2s";
>> >
>> > Same remark than for the spdif, please add a soc-specific compatible.
>>
>> Is that really necessary?..
>
> Yes.
>
>> for example on the a20 the functionality of the i2s is the same as
>> the a10 so it is down as "allwinner,sun4i-a10-i2s", likewise here
>> it's the same as the changes required for the H3. I was planning on
>> using the compatible "allwinner,sun50i-a64-i2s" for the audio codec
>> as there are some quirks that need to be addressed.
>
> And this is exactly why it is necessary. If we ever find a quirk in
> the future, supporting that quirk will be smooth if we already have a
> compatible for that SoC in the DT, and a pain if we don't.
ACK, but is there any reason why we're not doing this for i2c?
BR,
CK
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
