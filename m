From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 15:56:27 +0800
Subject: [linux-sunxi] [PATCH v2] arm64: allwinner: a64: Add A64-OLinuXino
 initial support
In-Reply-To: <CAD6G_RRMHMrm1wPGJCxQgmOuwhEqVK_zTZF1Fsv9az4tZ1uvBg@mail.gmail.com>
References: <1502560442-17715-1-git-send-email-jteki@openedev.com>
 <CAGb2v66Scd69iBNxhvYbkqjt7K_5m+S4nYG633O3wYAW_3CyLQ@mail.gmail.com>
 <CAD6G_RRMHMrm1wPGJCxQgmOuwhEqVK_zTZF1Fsv9az4tZ1uvBg@mail.gmail.com>
Message-ID: <CAGb2v64KJOuS=XfWu=tHyyYbTVjLJKVoTL2cQDyLby=CmnmLWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 3:34 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 12:38 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> Hi,
>>
>> On Sun, Aug 13, 2017 at 1:54 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>>> From: Jagan Teki <jagan@amarulasolutions.com>
>>>
>>> OLimex A64-OLinuXino is an open-source hardware board
>>> using the Allwinner A64 SOC.
>>>
>>> OLimex A64-OLinuXino has
>>> - A64 Quad-core Cortex-A53 64bit
>>> - 1GB or 2GB RAM DDR3L @ 672Mhz
>>> - microSD slot and 4/8/16GB eMMC
>>> - Debug TTL UART
>>> - HDMI
>>> - LCD
>>> - IR receiver
>>> - 5V DC power supply
>>
>> Have you tried out Ethernet?
>
> Not, tested yet. Will send separate patch.

OK.

[...]

>>> +
>>> +&reg_aldo2 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3300000>;
>>> +       regulator-max-microvolt = <3300000>;
>>
>> Schematic says 1.8V?
>
> I saw ALD02 VCC-PL=3.3v on schematic.

Ah. I see they changed it in a rev. B. Lets use 3.3V then.

>>
>>> +       regulator-name = "vcc-pl";
>>> +};
>>> +
>>> +&reg_aldo3 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3000000>;
>>> +       regulator-max-microvolt = <3000000>;
>>> +       regulator-name = "vcc-pll-avcc";
>>> +};
>>> +
>>> +&reg_dcdc1 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3300000>;
>>> +       regulator-max-microvolt = <3300000>;
>>> +       regulator-name = "vcc-3v3";
>>> +};
>>> +
>>> +&reg_dcdc2 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <1100000>;
>>> +       regulator-max-microvolt = <1100000>;
>>
>> The SoC has a wider range than a fixed voltage for the CPUs.
>
> So, max 1.1v can't enough CPUs? thought similar behavior with pine64?

The recommended operating conditions says 1.04 ~ 1.3 V for CPUx,
while the typical voltage is 1.1V. The regulator constraints should
match the datasheet, especially for power rails that are involved in
DVFS.

ChenYu
