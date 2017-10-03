From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Oct 2017 10:14:30 +0800
Subject: [PATCH 5/7] ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818
 regulator nodes
In-Reply-To: <20171002162405.jndvig3fxuj6d3ce@flea>
References: <20170929032514.31727-1-wens@csie.org>
 <20170929032514.31727-6-wens@csie.org>
 <20171002162405.jndvig3fxuj6d3ce@flea>
Message-ID: <CAGb2v64dYZePt20h+Q4iB0Xcp1qc=VCpMzJfzkxjPQMqfxnfJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 12:24 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Sep 29, 2017 at 03:25:12AM +0000, Chen-Yu Tsai wrote:
>> +#include "axp81x.dtsi"
>> +
>> +&reg_aldo1 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1800000>;
>> +     regulator-max-microvolt = <1800000>;
>> +     regulator-name = "vcc18-csi2-dsi-efuse-hdmi-d4dp";
>> +};
>
> I'm not really fond of these names. It's easy to miss some components
> (especially since we most of the time don't have the schematics), and
> if it's not complete, the obscure name isn't worth it either.

If we don't have schematics, then yeah it's impossible to name them
accurately. But we do have it for this board.

> What about vcc-1.8 for this one ?

It's only vcc-1.8 for some components, as the next one provides
vcc-1.8 for the SoC's PLLs. The pin for that is named "vcc18-pll"
in the datasheet.

>
>> +&reg_aldo2 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1800000>;
>> +     regulator-max-microvolt = <1800000>;
>> +     regulator-name = "vdd-drampll-vcc18-pll-adc-cpvdd-ldoin";
>> +};
>
> dram-pll?
>
>> +&reg_aldo3 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <3000000>;
>> +     regulator-max-microvolt = <3000000>;
>> +     regulator-name = "vcc-pl-avcc";
>> +};
>
> avcc?
>
> etc..

The schematics don't provide rail names for the outputs. They
are all just have names matching the regulators. The ones that
do look pretty here are because they are only tied to one thing.

If the names are too long and confusing, I suggest we just use
the regulator names from the PMIC.

>
>>       status = "disabled";
>>  };
>>
>> +&reg_vcc3v3 {
>> +     status = "disabled";
>> +};
>> +
>>  &reg_vcc5v0 {
>>       status = "disabled";
>>  };
>
> Why not simply remove the DTSI then?

I'm still using the USB VBUS regulators. But I suppose I should weigh the
amount of used vs unused shared code.

ChenYu
