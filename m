From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 2 Apr 2018 12:06:48 +0530
Subject: [PATCH v5 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
In-Reply-To: <20180327174913.GP1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-14-git-send-email-sricharan@codeaurora.org>
 <20180327174913.GP1403@tuxbook-pro>
Message-ID: <c02ed3b7-30e6-29a0-a68d-fcb96ace2841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,


On 3/27/2018 11:19 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> 
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 103 ++++++++++++++++++++++++++++++
>>  1 file changed, 103 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> index 6a838b5..dbca7ec 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> @@ -21,6 +21,7 @@
>>  
>>  	aliases {
>>  		serial0 = &blsp1_uart5;
>> +		serial1 = &serial_blsp2;
>>  	};
>>  
>>  	chosen {
>> @@ -41,6 +42,47 @@
>>  					bias-disable;
>>  				};
>>  			};
>> +
>> +			 i2c_0_pins: i2c_0_pinmux {
>> +				  mux {
>> +					   pins = "gpio42", "gpio43";
>> +					   function = "blsp1_i2c";
>> +					   drive-strength = <8>;
>> +					   bias-disable;
>> +				  };
>> +			 };
>> +
>> +			 spi_0_pins: spi_0_pins {
>> +				  mux {
>> +					   pins = "gpio38", "gpio39", "gpio40", "gpio41";
>> +					   function = "blsp0_spi";
>> +					   drive-strength = <8>;
>> +					   bias-disable;
>> +				  };
>> +			 };
>> +
>> +			 hsuart_pins: hsuart_pins {
>> +				  mux {
>> +					   pins = "gpio46", "gpio47", "gpio48", "gpio49";
>> +					   function = "blsp2_uart";
>> +					   drive-strength = <8>;
>> +					   bias-disable;
>> +				  };
>> +			 };
>> +
>> +			 qpic_pins: qpic_pins {
>> +				mux {
>> +					   pins = "gpio1", "gpio3", "gpio4",
>> +						  "gpio5", "gpio6", "gpio7",
>> +						  "gpio8", "gpio10", "gpio11",
>> +						  "gpio12", "gpio13", "gpio14",
>> +						  "gpio15", "gpio16", "gpio17";
>> +					   function = "qpic";
> 
> I would prefer that you move the pinmux part to the same dtsi that
> defines the nand and add the board specific pinconf (electrical
> properties) here. That way we limit the repetition between the board
> files.
> 

 sure. will do.

>> +					   drive-strength = <8>;
>> +					   bias-disable;
>> +				  };
>> +			};
>> +
>>  		};
>>  
> 
> Other than that,
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

 Thanks. Again, thanks for your time and all the reviews.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
