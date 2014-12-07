From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 8 Dec 2014 00:00:21 +0800
Subject: [PATCH 05/10] ARM: dts: sun9i: Add mmc config clock nodes
In-Reply-To: <20141207150039.GE12434@lukather>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-6-git-send-email-wens@csie.org>
 <20141207150039.GE12434@lukather>
Message-ID: <CAGb2v67=D+7vO3QoC5VcUcWAJtFLDLs_+XzZqQA4=cBLPdratg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 7, 2014 at 11:00 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Dec 03, 2014 at 02:36:00PM +0800, Chen-Yu Tsai wrote:
>> Add the device tree nodes for the mmc config clock nodes.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
>> index f3cac3a..f425d9d 100644
>> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
>> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
>> @@ -325,6 +325,19 @@
>>                */
>>               ranges = <0 0 0 0x20000000>;
>>
>> +             mmc_config_clk: clk at 01c23000 {
>> +                     compatible = "allwinner,sun9i-a80-mmc-clk";
>> +                     reg = <0x01c13000 0x10>;
>
> The reg and the unit-address don't match.

Will fix.

> Also, this used to be defined in the clocks node for the USB case, it
> would be good to do the same here.

As it is a platform driver, it can't be under the clocks node, which
doesn't instantiate platform devices. (That is, assuming you're ok
with it being a platform driver.)

ChenYu
