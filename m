From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 11 Dec 2017 16:31:20 +0800
Subject: [PATCH 1/5] arm: dts: sun8i: a83t: Add I2C0 node
In-Reply-To: <20171211071513.xgni3t6ihmeeebre@flea.lan>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-2-mylene.josserand@free-electrons.com>
 <20171211071513.xgni3t6ihmeeebre@flea.lan>
Message-ID: <CAGb2v64awf8YwBM-M6GS_dy+6mpT1e5Bzy-zLYNfRmjLGb55bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 3:15 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Dec 08, 2017 at 10:54:15PM +0100, Myl?ne Josserand wrote:
>> Add I2C0 node for A83T.
>>
>> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/sun8i-a83t.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
>> index 19acae1b4089..848cf3f19962 100644
>> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
>> @@ -177,6 +177,17 @@
>>                       #dma-cells = <1>;
>>               };
>>
>> +             i2c0: i2c at 01c2ac00 {
>
> Drop the leading 0, it generates a warning in dtc.
>
>> +                     compatible = "allwinner,sun6i-a31-i2c";
>
> Can you add a SoC-specific compatible there please?
>
>> +                     reg = <0x01c2ac00 0x400>;
>
> And you should order your nodes by physical address.

I have a similar patch in my A83T I2S branch:

https://github.com/wens/linux/commit/8b76a3e555b39a06f3f8182e4ff5645de4c4cbc3

ChenYu
