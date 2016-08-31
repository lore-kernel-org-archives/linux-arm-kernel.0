From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 31 Aug 2016 11:48:07 +0200
Subject: [PATCH v2 5/6] ARM: tegra: Add Tegra20 GMI support
In-Reply-To: <1472627926.31008.7.camel@toradex.com>
References: <1472569349.5703.25.camel@toradex.com>
 <1472627926.31008.7.camel@toradex.com>
Message-ID: <CALw8SCW49jOZ7gBTwhNLSMeeDUCYUpRs-GNgXo84pOkUfLTcUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-31 9:18 GMT+02:00 Marcel Ziswiler <marcel.ziswiler@toradex.com>:
> On Wed, 2016-08-24 at 15:37 +0200, Mirza Krak wrote:
>>
>> From: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Add a device node for the GMI controller found on Tegra20.
>>
>> Signed-off-by: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.g
>> mane.org>
>> ---
>> Changes in v2:
>> - added address-cells, size-cells and ranges properties
>>
>>  arch/arm/boot/dts/tegra20.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi
>> b/arch/arm/boot/dts/tegra20.dtsi
>> index 2207c08..03eb029 100644
>> --- a/arch/arm/boot/dts/tegra20.dtsi
>> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> @@ -376,6 +376,20 @@
>>               status = "disabled";
>>       };
>>
>> +
>> +     gmi at 70009000 {
>> +             compatible = "nvidia,tegra20-gmi";
>> +             reg = <70009000 0x1000>;
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges = <0 0x48000000 0x7ffffff>;
>
> On T20 it is actually rather 0xd0000000.

It indeed is, thank you catching this.

Best Regards
Mirza
