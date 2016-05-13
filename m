From: kernel@martin.sperl.org (Martin Sperl)
Date: Fri, 13 May 2016 08:29:37 +0200
Subject: [PATCH 3/4] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
In-Reply-To: <87posqamh9.fsf@eliezer.anholt.net>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
 <1463063738-11506-4-git-send-email-kernel@martin.sperl.org>
 <87posqamh9.fsf@eliezer.anholt.net>
Message-ID: <FA3695BE-D1A7-44E3-9714-08B6A002EB06@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 13.05.2016, at 01:24, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Add the node for the thermal sensor of the bcm2835-soc
>> to the device tree.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
>> index 9db9d97..525f1f2 100644
>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>> @@ -159,6 +159,12 @@
>> 			status = "disabled";
>> 		};
>> 
>> +		thermal: thermal at 0x7e212000 {
>> +			compatible = "brcm,bcm2835-thermal";
>> +			reg = <0x7e212000 0x8>;
>> +			clocks = <&clocks BCM2835_CLOCK_TSENS>;
>> +		};
>> +
> 
> You could drop the "thermal: " here since nothing refers to it.  Either
> way,
Actually you will refer to it in the device tree for the bcm2837
so that you can set a different compatible string.
