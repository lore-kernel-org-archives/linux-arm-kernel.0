From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Jan 2018 19:02:08 +0800
Subject: [linux-sunxi][PATCH 2/5] arm64: allwinner: a64: Add SPDIF TX pin
 to the A64
In-Reply-To: <20180124110031.kksmh56krinaivh7@flea.lan>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-3-codekipper@gmail.com>
 <20180124110031.kksmh56krinaivh7@flea.lan>
Message-ID: <CAGb2v67oFc0LRAcdvh-2F3HRkOui34ANp_-frB9exdvFBAirqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 7:00 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jan 24, 2018 at 11:39:40AM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Add the SPDIF TX pin to the A64 dtsi.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index c82979038b0b..db1694ec3ee4 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -336,6 +336,11 @@
>>                               drive-strength = <40>;
>>                       };
>>
>> +                     spdif_tx_pins_a: spdif at 0 {
>
> This will generate a dtc warning, you should use a syntax similar to
> the other nodes there (ie. spdif if that's the only muxing option, or
> spdif-0).

Furthermore, if this is the only option, you should set it as the
default in the .dtsi, so boards don't have to, and possibly squash
this patch into the first one.

ChenYu
