From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 7 Dec 2014 23:11:06 +0800
Subject: [PATCH 09/10] ARM: dts: sun9i: Add pinmux settings for mmc2
In-Reply-To: <20141207150353.GH12434@lukather>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-10-git-send-email-wens@csie.org>
 <20141207150353.GH12434@lukather>
Message-ID: <CAGb2v64X8AvnqMFxxeHLa28G_7sF9vYjqU_D7R_=L4NJ+=ae7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 7, 2014 at 11:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Dec 03, 2014 at 02:36:04PM +0800, Chen-Yu Tsai wrote:
>> mmc2 is available on port C. Add a pinmux setting for usual 4 bit
>> wide bus, as well as one with the 4 extra pins for 8 bit wide bus.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  arch/arm/boot/dts/sun9i-a80.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
>> index f5b5645..fc866d8 100644
>> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
>> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
>> @@ -466,6 +466,21 @@
>>                               allwinner,pull = <0>;
>>                       };
>>
>> +                     mmc2_pins: mmc2 {
>> +                             allwinner,pins = "PC6","PC7","PC8","PC9",
>> +                                              "PC10","PC11";
>> +                             allwinner,function = "mmc2";
>> +                             allwinner,drive = <2>;
>> +                             allwinner,pull = <1>;
>> +                     };
>> +
>> +                     mmc2_8bit_pins: mmc2_8bit {
>> +                             allwinner,pins = "PC12","PC13","PC14","PC15";
>> +                             allwinner,function = "mmc2";
>> +                             allwinner,drive = <2>;
>> +                             allwinner,pull = <1>;
>> +                     };
>> +
>
> Hmmm, how is that 8 bits? There's only 4 pins here.

The 8bit setting only includes the upper 4 bits.
Using both settings together you get an 8 bit bus,
along with CMD and CLK pins, for a total of 10 pins.

Or is this the wrong way?

ChenYu
