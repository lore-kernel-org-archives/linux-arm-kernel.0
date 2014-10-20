From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Mon, 20 Oct 2014 17:38:42 +0300
Subject: [PATCH] ARM: DT: apq8064: Add Support for SD Card Detect for
 ifc6410 board
In-Reply-To: <5444F62D.1090801@smartplayin.com>
References: <1413805194-4360-1-git-send-email-pramod.gurav@smartplayin.com>
 <5444F62D.1090801@smartplayin.com>
Message-ID: <54451E72.6060900@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 02:46 PM, Pramod Gurav wrote:
> +linux-arm-msm
> 
> On Monday 20 October 2014 05:09 PM, Pramod Gurav wrote:
>> This changes muxes in gpio26 pin to function as gpio and adds support
>> for sd card detect for apq8064 based IFC6410 board.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> index b396c83..bf6262f 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> @@ -12,6 +12,14 @@
>>  					function = "gsbi1";
>>  				};
>>  			};
>> +
>> +			card_detect: card_detect {
>> +				mux {
>> +					pins = "gpio26";
>> +					function = "gpio";
>> +					bias-disable;
>> +				};
>> +			};
>>  		};
>>  
>>  		gsbi at 12440000 {
>> @@ -49,6 +57,9 @@
>>  			/* External micro SD card */
>>  			sdcc3: sdcc at 12180000 {
>>  				status = "okay";
>> +				pinctrl-names	= "default";
>> +				pinctrl-0	= <&card_detect>;
>> +				cd-gpios	= <&tlmm_pinmux 26 1>;

pls use the defines in gpio.h.

<&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;

-- 
regards,
Stan
