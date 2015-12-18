From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Fri, 18 Dec 2015 11:57:25 +0200
Subject: [PATCH v4 5/5] ARM: dts: ifc6410: enable pcie dt node for this
 board
In-Reply-To: <20151217215553.GA4000@usrtlx11787.corpusers.net>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-6-git-send-email-stanimir.varbanov@linaro.org>
 <20151217215553.GA4000@usrtlx11787.corpusers.net>
Message-ID: <5673D885.30803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2015 11:55 PM, Bjorn Andersson wrote:
> On Thu 03 Dec 05:35 PST 2015, Stanimir Varbanov wrote:
> 
>> Enable pcie dt node and fill pcie dt node with regulator, pinctrl
>> and reset gpio, to use the pcie on the ifc6410 board.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |   26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> index 11ac608b6d50..f203b94ee460 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> @@ -47,6 +47,18 @@
>>  					bias-disable;
>>  				};
>>  			};
>> +
>> +			pcie_pins: pcie_pinmux {
>> +				mux {
>> +					pins = "gpio27";
>> +					function = "gpio";
>> +				};
>> +				conf {
>> +					pins = "gpio27";
>> +					drive-strength = <12>;
>> +					bias-disable;
>> +				};
>> +			};
>>  		};
>>  
>>  		rpm at 108000 {
>> @@ -123,6 +135,10 @@
>>  				pm8921_lvs1: lvs1 {
>>  					bias-pull-down;
>>  				};
>> +
>> +				pm8921_lvs6: lvs6 {
>> +					bias-pull-down;
>> +				};
> 
> Please don't duplicate the labels in the dts files.

Sorry, I based those dts patches before [1] has been applied in -next. I
will rebase this patch on top of [1]. Thanks!

[1] "ARM: dts: qcom: apq8064: Declare all pm8921 regulators"

-- 
regards,
Stan
