From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 18 Sep 2013 14:36:18 +0200
Subject: [PATCH 4/4] ARM: STi: Add I2C config to B2000 and B2020 boards
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-5-git-send-email-maxime.coquelin@st.com>
 <20130918114032.GD16984@lee--X1>
Message-ID: <84625B87D65BCF478CC1E9C886A4C314DEF1BD9576@SAFEX1MAIL4.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 09/18/2013 01:40 PM, Lee Jones wrote:
> On Wed, 18 Sep 2013, Maxime COQUELIN wrote:
>
>> This patch supplies I2C configuration to B2000 and B2020
>> based on either STiH415 or STiH416 SoCs.
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>> ---
>>  arch/arm/boot/dts/stih41x-b2000.dtsi |    7 +++++++
>>  arch/arm/boot/dts/stih41x-b2020.dtsi |   20 ++++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
>> index 8e694d2..346cc4bc 100644
>> --- a/arch/arm/boot/dts/stih41x-b2000.dtsi
>> +++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
>> @@ -37,5 +37,12 @@
>>  			};
>>  		};
>>  
>> +		/* HDMI Tx I2C */
>> +		i2c1: i2c at fed41000{
> nit: Space before the '{'
Ok. It will be fixed for all nodes in next series.
>
>> +			status = "okay";
> Consider enabling the node at the bottom.
>
>> +
>> +			/* HDMI V1.3a supports Standard mode only */
>> +			clock-frequency = <100000>;
>> +		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
>> index 133e181..10b98da 100644
>> --- a/arch/arm/boot/dts/stih41x-b2020.dtsi
>> +++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
>> @@ -38,5 +38,25 @@
>>  				default-state = "off";
>>  			};
>>  		};
>> +
>> +		i2c0: i2c at fed40000{
> As above.
>
>> +			status = "okay";
>> +		};
>> +
>> +		/* HDMI Tx I2C */
>> +		i2c1: i2c at fed41000{
> As above.
>
>> +			status = "okay";
> As above.
>
>> +			/* HDMI V1.3a supports Standard mode only */
>> +			clock-frequency = <100000>;
>> +		};
>> +
>> +		sbc_i2c0: i2c at fe540000{
> As above.
>
>> +			status = "okay";
>> +		};
>> +
>> +		sbc_i2c1: i2c at fe541000{
> Are these nodes referenced by phandle at all?
>
> If not, consider dropping the <lable>:s
It was references in an previous internal version of this series.
This is no more the case, so I will drop the labels.
>
>> +			status = "okay";
>> +		};
>>  	};
>>  };
> Odd tabbing here.
>
Thanks,
Maxime
