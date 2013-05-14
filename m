From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 14 May 2013 11:20:00 +0200
Subject: [RFC PATCH v3 05/17] ARM: dts: at91: cpus/cpu node dts updates
In-Reply-To: <517E4366.4040209@atmel.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366824502-19729-6-git-send-email-lorenzo.pieralisi@arm.com>
 <517E4366.4040209@atmel.com>
Message-ID: <519201C0.2060908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/2013 11:54, Nicolas Ferre :
> On 04/24/2013 07:28 PM, Lorenzo Pieralisi :
>> This patch updates the in-kernel dts files according to the latest cpus
>> and cpu bindings updates for ARM.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> With changes in compatible string... ok then.
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Now that our Cortex-A5 is in mainline, can you please update the:

arch/arm/boot/dts/sama5d3.dtsi

as-well?

Thanks, best regards,

>> ---
>>   arch/arm/boot/dts/at91rm9200.dtsi  | 6 +++++-
>>   arch/arm/boot/dts/at91sam9260.dtsi | 8 ++++++--
>>   arch/arm/boot/dts/at91sam9263.dtsi | 8 ++++++--
>>   arch/arm/boot/dts/at91sam9g45.dtsi | 8 ++++++--
>>   arch/arm/boot/dts/at91sam9n12.dtsi | 8 ++++++--
>>   arch/arm/boot/dts/at91sam9x5.dtsi  | 8 ++++++--
>>   6 files changed, 35 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
>> index b0268a5..f16b3d4 100644
>> --- a/arch/arm/boot/dts/at91rm9200.dtsi
>> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
>> @@ -34,8 +34,12 @@
>>   		ssc2 = &ssc2;
>>   	};
>>   	cpus {
>> -		cpu at 0 {
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +
>> +		cpu {
>>   			compatible = "arm,arm920t";
>> +			device_type = "cpu";
>>   		};
>>   	};
>>
>> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
>> index cb7bcc5..c4eeef7 100644
>> --- a/arch/arm/boot/dts/at91sam9260.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
>> @@ -32,8 +32,12 @@
>>   		ssc0 = &ssc0;
>>   	};
>>   	cpus {
>> -		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +
>> +		cpu {
>> +			compatible = "arm,arm926ej-s";
>> +			device_type = "cpu";
>>   		};
>>   	};
>>
>> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
>> index 271d4de..f3b5c2a 100644
>> --- a/arch/arm/boot/dts/at91sam9263.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
>> @@ -29,8 +29,12 @@
>>   		ssc1 = &ssc1;
>>   	};
>>   	cpus {
>> -		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +
>> +		cpu {
>> +			compatible = "arm,arm926ej-s";
>> +			device_type = "cpu";
>>   		};
>>   	};
>>
>> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
>> index 6b1d4ca..6c18bd3 100644
>> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
>> @@ -35,8 +35,12 @@
>>   		ssc1 = &ssc1;
>>   	};
>>   	cpus {
>> -		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +
>> +		cpu {
>> +			compatible = "arm,arm926ej-s";
>> +			device_type = "cpu";
>>   		};
>>   	};
>>
>> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
>> index 7750f98..c3b11af 100644
>> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
>> @@ -31,8 +31,12 @@
>>   		ssc0 = &ssc0;
>>   	};
>>   	cpus {
>> -		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +
>> +		cpu {
>> +			compatible = "arm,arm926ej-s";
>> +			device_type = "cpu";
>>   		};
>>   	};
>>
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index aa98e64..6c39d0f 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -33,8 +33,12 @@
>>   		ssc0 = &ssc0;
>>   	};
>>   	cpus {
>> -		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +
>> +		cpu {
>> +			compatible = "arm,arm926ej-s";
>> +			device_type = "cpu";
>>   		};
>>   	};
>>
>>
>
>


-- 
Nicolas Ferre
