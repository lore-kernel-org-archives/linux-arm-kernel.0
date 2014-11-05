From: bhuvanchandra.dv@toradex.com (BhuvanChandra.DV)
Date: Wed, 5 Nov 2014 14:31:13 +0530
Subject: [PATCH 1/2] ARM: dts: vf-colibri: Add I2C support
In-Reply-To: <8dcb8f78771fe356b9648e74354003e9@agner.ch>
References: <cover.1415099486.git.bhuvanchandra.dv@toradex.com>
 <d5e07584708523262df69f5a4dec10609f77baa3.1415099486.git.bhuvanchandra.dv@toradex.com>
 <8dcb8f78771fe356b9648e74354003e9@agner.ch>
Message-ID: <5459E759.4020606@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 November 2014 02:16 PM, Stefan Agner wrote:

> Am 2014-11-04 12:22, schrieb Bhuvanchandra DV:
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>> ---
>>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |    7 ++++++-
>>  arch/arm/boot/dts/vf-colibri.dtsi         |   13 +++++++++++++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> index 80e8fbc..0251e6c 100644
>> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
>> @@ -33,6 +33,11 @@
>>  	status = "okay";
>>  };
>>  
>> +&i2c0 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +};
>> +
>>  &pwm0 {
>>  	status = "okay";
>>  };
>> @@ -51,4 +56,4 @@
>>  
>>  &uart2 {
>>  	status = "okay";
>> -};
>> \ No newline at end of file
>> +};
>> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi
>> b/arch/arm/boot/dts/vf-colibri.dtsi
>> index ab40367..471eec0 100644
>> --- a/arch/arm/boot/dts/vf-colibri.dtsi
>> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
>> @@ -39,6 +39,12 @@
>>  	pinctrl-0 = <&pinctrl_fec1>;
>>  };
>>  
>> +&i2c0 {
>> +	clock-frequency = <400000>;
> There is no need to overwrite the clock frequency again on carrier board
> level here.

Ok

>
> But other than that.
>
> Acked-by: Stefan Agner <stefan@agner.ch>
>
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c0>;
>> +};
>> +
>>  &pwm0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_pwm0>;
>> @@ -102,6 +108,13 @@
>>  			>;
>>  		};
>>  
>> +		pinctrl_i2c0: i2c0grp {
>> +			fsl,pins = <
>> +				VF610_PAD_PTB14__I2C0_SCL		0x37ff
>> +				VF610_PAD_PTB15__I2C0_SDA		0x37ff
>> +			>;
>> +		};
>> +
>>  		pinctrl_pwm0: pwm0grp {
>>  			fsl,pins = <
>>  				VF610_PAD_PTB0__FTM0_CH0		0x1182
