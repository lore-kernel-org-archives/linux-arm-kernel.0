From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Oct 2015 16:35:26 +0800
Subject: [PATCH v2 1/5] ARM: dts: sun6i: hummingbird: Fix VDD-CPU and
 VDD-GPU regulator names
In-Reply-To: <20151012083126.GX2278@lukather>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-2-git-send-email-wens@csie.org>
 <20151012083126.GX2278@lukather>
Message-ID: <CAGb2v66cj-5EmfbE8Ci4BffSCrxeqd+Yaftp-enM+qcGQSjkFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 4:31 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sat, Oct 10, 2015 at 10:48:56PM +0800, Chen-Yu Tsai wrote:
>> The VDD-CPU and VDD-GPU regulators were incorrectly swapped.
>>
>> Fixes: bab03561224ba ("ARM: dts: sun6i: hummingbird: Add AXP221 regulator
>>        nodes")
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> index f9d9fc07bc63..e25d4924dbe7 100644
>> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> @@ -191,18 +191,18 @@
>>                               regulator-name = "vcc-3v0";
>>                       };
>>
>> -                     vdd_cpu: dcdc2 {
>> +                     vdd_gpu: dcdc2 {
>>                               regulator-always-on;
>>                               regulator-min-microvolt = <700000>;
>>                               regulator-max-microvolt = <1320000>;
>> -                             regulator-name = "vdd-cpu";
>> +                             regulator-name = "vdd-gpu";
>>                       };
>
> Do we need to leave the GPU regulator on ?

No. But that is addressed in patch 3, which converts to using axp22x.dtsi.

I wanted to keep this fix as simple as possible.

ChenYu
