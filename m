From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Oct 2014 11:01:02 +0800
Subject: [PATCH v2 7/7] ARM: dts: sun6i: Add required ahb1 clock parent
 and rates for dma controller
In-Reply-To: <20140930155533.GP4081@lukather>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-8-git-send-email-wens@csie.org>
 <20140930155533.GP4081@lukather>
Message-ID: <CAGb2v64TE=gzPdFJwfmJfpwWZcsdZQGONh11SawfBXZkWGFKCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 11:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Sep 27, 2014 at 04:49:55PM +0800, Chen-Yu Tsai wrote:
>> The DMA controller requires AHB1 bus clock to be clocked from PLL6.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index caf879d..d7845d3 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -353,6 +353,11 @@
>>                       clocks = <&ahb1_gates 6>;
>>                       resets = <&ahb1_rst 6>;
>>                       #dma-cells = <1>;
>> +
>> +                     /* DMA controller requires AHB1 clocked from PLL6 */
>> +                     assigned-clocks = <&ahb1>;
>> +                     assigned-clock-parents = <&pll6 0>;
>> +                     assigned-clock-rates = <200000000>;
>
> Again, I don't think we need the rate change, and that it's the right
> place to put it.

I'll drop it. As you mentioned on IRC, re-parenting to pll6
is still required, so I'll keep that bit.

Hi, Mike,

Is there a recommended way for clock providers to enforce a range
on clock rates? Tomeu's patches seem to be for clock consumers.

Cheers
ChenYu
