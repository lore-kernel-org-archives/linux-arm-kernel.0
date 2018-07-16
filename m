From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 16 Jul 2018 08:52:36 -0500
Subject: [PATCH v2] ARM64: dts: meson-axg: add saradc support
In-Reply-To: <1531326349.2708.136.camel@baylibre.com> (Jerome Brunet's message
 of "Wed, 11 Jul 2018 18:25:49 +0200")
References: <20180702222515.13924-1-yixun.lan@amlogic.com>
 <1531326349.2708.136.camel@baylibre.com>
Message-ID: <7h7elvmgnv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Mon, 2018-07-02 at 22:25 +0000, Yixun Lan wrote:
>> From: Xingyu Chen <xingyu.chen@amlogic.com>
>> 
>> Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.
>> 
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>> Hi kevin
>>   I just re-send this patch which rebased to your khilman/v4.18/integ branch
>>   Thanks
>> Yixun
>> 
>> nothing changed since patch v1 [1]:
>>  -
>> 
>> [1] https://lkml.kernel.org/r/20180326092117.208416-1-yixun.lan at amlogic.com
>> 
>> ---
>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 21 +++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> index 4b3331fbfe39..6041f68b32ae 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> @@ -153,3 +153,8 @@
>>  		compatible = "brcm,bcm4329-fmac";
>>  	};
>>  };
>> +
>> +&saradc {
>> +	status = "okay";
>> +	vref-supply = <&vddio_ao18>;
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 67d7115e4eff..52678a69dbf8 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -91,6 +91,13 @@
>>  		method = "smc";
>>  	};
>>  
>> +	vddio_ao18: regulator-vddio_ao18 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDDIO_AO18";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +	};
>
> Kevin, Yixun,
>
> I find odd that we are adding a regulator to SoC device tree file.
> Those regulator are usually part of board file
>
> Unless the regulator is actually inside the SoC, this is not the place for it.
>
> Sorry for not catching this earlier.

You're right, I should've noticed this earlier also.

Yixun, can you resend this with the regulators in the board file please?

In the mean time, I've dropped this from v4.19/dt64 branch,

Kevin
