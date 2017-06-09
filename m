From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 09 Jun 2017 17:26:32 +0900
Subject: [PATCH] ARM: dts: exynos: Add the OF graph between fimd and dsi
In-Reply-To: <20170609072754.GB4018@kozik-book>
References: <CGME20170609025951epcas1p19f5ca8c241b8b79068a84eb239ed46ed@epcas1p1.samsung.com>
 <1496977173-20550-1-git-send-email-hoegeun.kwon@samsung.com>
 <20170609072754.GB4018@kozik-book>
Message-ID: <a98fe97c-6196-c7a1-d458-8a7204531e80@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2017 04:27 PM, Krzysztof Kozlowski wrote:
> On Fri, Jun 09, 2017 at 11:59:33AM +0900, Hoegeun Kwon wrote:
>> It should be connected to OF graph between fimd and dsi.
>> Add the OF graph between fimd and dsi.
> I need more explanation why this is needed. What happens without this?
> What issue is fixed here?
>
> What about Exynos5250 and Exynos5420? I think we do not have a board in
> mainline using FIMD but maybe this should be added just for correct
> hardware description?

Thank you for your review.

I'm sorry, this patch is wrong.
Please ignore this patch. :)

Best regards,
Hoegeun

>
>
> Best regards,
> Krzysztof
>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos3250.dtsi | 26 ++++++++++++++++++++++++++
>>   arch/arm/boot/dts/exynos4.dtsi    | 26 ++++++++++++++++++++++++++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>> index 590ee44..22d523f 100644
>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>> @@ -311,6 +311,19 @@
>>   			iommus = <&sysmmu_fimd0>;
>>   			samsung,sysreg = <&sys_reg>;
>>   			status = "disabled";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port at 0 {
>> +					reg = <0>;
>> +					fimd_to_dsi: endpoint {
>> +						remote-endpoint =
>> +							<&dsi_to_fimd>;
>> +					};
>> +				};
>> +			};
>>   		};
>>   
>>   		dsi_0: dsi at 11C80000 {
>> @@ -326,6 +339,19 @@
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>>   			status = "disabled";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port at 0 {
>> +					reg = <0>;
>> +					dsi_to_fimd: endpoint {
>> +						remote-endpoint =
>> +							<&fimd_to_dsi>;
>> +					};
>> +				};
>> +			};
>>   		};
>>   
>>   		sysmmu_fimd0: sysmmu at 11E20000 {
>> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
>> index 497a947..773d392 100644
>> --- a/arch/arm/boot/dts/exynos4.dtsi
>> +++ b/arch/arm/boot/dts/exynos4.dtsi
>> @@ -193,6 +193,19 @@
>>   		status = "disabled";
>>   		#address-cells = <1>;
>>   		#size-cells = <0>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 0 {
>> +				reg = <0>;
>> +				dsi_to_fimd: endpoint {
>> +					remote-endpoint =
>> +						<&fimd_to_dsi>;
>> +				};
>> +			};
>> +		};
>>   	};
>>   
>>   	camera {
>> @@ -715,6 +728,19 @@
>>   		iommus = <&sysmmu_fimd0>;
>>   		samsung,sysreg = <&sys_reg>;
>>   		status = "disabled";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 0 {
>> +				reg = <0>;
>> +				fimd_to_dsi: endpoint {
>> +					remote-endpoint =
>> +						<&dsi_to_fimd>;
>> +				};
>> +			};
>> +		};
>>   	};
>>   
>>   	tmu: tmu at 100C0000 {
>> -- 
>> 1.9.1
>>
>
>
