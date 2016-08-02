From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 2 Aug 2016 15:58:40 +0200
Subject: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
In-Reply-To: <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
 <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
Message-ID: <cc932ae0-3198-38cc-b6fa-2c97530cdb3b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-08-16 15:11, Andre Przywara wrote:
> Hi Hans,
>
> On 30/07/16 15:25, Hans de Goede wrote:
>> Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
>> and newer.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -New patch in v2 of this patch-set
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi     | 8 ++++----
>>  arch/arm/boot/dts/sun7i-a20.dtsi     | 8 ++++----
>>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
>>  arch/arm/boot/dts/sun8i-h3.dtsi      | 6 +++---
>>  4 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index 1867af2..0d24f10 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -469,7 +469,7 @@
>>  		};
>>
>>  		mmc0: mmc at 01c0f000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>
> But that breaks systems with newer DTs on older kernels, which do not
> know about sun7i-a20-mmc. I assume this somehow worked before(?), so why
> not use:
> 	compatible = "allwinner,sun7i-a20-mmc",
> 		     "allwinner,sun5i-a13-mmc";
>
> So newer kernels would pick up the new name and behaviour, while older
> kernels would revert to the old name and use the existing driver.

Good idea, I'll send a v3 with this change.

Regards,

Hans



>
> Cheers,
> Andre.
>
>>  			reg = <0x01c0f000 0x1000>;
>>  			clocks = <&ahb1_gates 8>,
>>  				 <&mmc0_clk 0>,
>> @@ -488,7 +488,7 @@
>>  		};
>>
>>  		mmc1: mmc at 01c10000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c10000 0x1000>;
>>  			clocks = <&ahb1_gates 9>,
>>  				 <&mmc1_clk 0>,
>> @@ -507,7 +507,7 @@
>>  		};
>>
>>  		mmc2: mmc at 01c11000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c11000 0x1000>;
>>  			clocks = <&ahb1_gates 10>,
>>  				 <&mmc2_clk 0>,
>> @@ -526,7 +526,7 @@
>>  		};
>>
>>  		mmc3: mmc at 01c12000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c12000 0x1000>;
>>  			clocks = <&ahb1_gates 11>,
>>  				 <&mmc3_clk 0>,
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index bd0c476..94cf5a1 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -905,7 +905,7 @@
>>  		};
>>
>>  		mmc0: mmc at 01c0f000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c0f000 0x1000>;
>>  			clocks = <&ahb_gates 8>,
>>  				 <&mmc0_clk 0>,
>> @@ -922,7 +922,7 @@
>>  		};
>>
>>  		mmc1: mmc at 01c10000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c10000 0x1000>;
>>  			clocks = <&ahb_gates 9>,
>>  				 <&mmc1_clk 0>,
>> @@ -939,7 +939,7 @@
>>  		};
>>
>>  		mmc2: mmc at 01c11000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c11000 0x1000>;
>>  			clocks = <&ahb_gates 10>,
>>  				 <&mmc2_clk 0>,
>> @@ -956,7 +956,7 @@
>>  		};
>>
>>  		mmc3: mmc at 01c12000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c12000 0x1000>;
>>  			clocks = <&ahb_gates 11>,
>>  				 <&mmc3_clk 0>,
>> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
>> index 7e05e09..e3b196e 100644
>> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
>> @@ -266,7 +266,7 @@
>>  		};
>>
>>  		mmc0: mmc at 01c0f000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c0f000 0x1000>;
>>  			clocks = <&ahb1_gates 8>,
>>  				 <&mmc0_clk 0>,
>> @@ -285,7 +285,7 @@
>>  		};
>>
>>  		mmc1: mmc at 01c10000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c10000 0x1000>;
>>  			clocks = <&ahb1_gates 9>,
>>  				 <&mmc1_clk 0>,
>> @@ -304,7 +304,7 @@
>>  		};
>>
>>  		mmc2: mmc at 01c11000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c11000 0x1000>;
>>  			clocks = <&ahb1_gates 10>,
>>  				 <&mmc2_clk 0>,
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index 93c88f3..b5cc2dc 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -154,7 +154,7 @@
>>  		};
>>
>>  		mmc0: mmc at 01c0f000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c0f000 0x1000>;
>>  			clocks = <&ccu CLK_BUS_MMC0>,
>>  				 <&ccu CLK_MMC0>,
>> @@ -173,7 +173,7 @@
>>  		};
>>
>>  		mmc1: mmc at 01c10000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c10000 0x1000>;
>>  			clocks = <&ccu CLK_BUS_MMC1>,
>>  				 <&ccu CLK_MMC1>,
>> @@ -192,7 +192,7 @@
>>  		};
>>
>>  		mmc2: mmc at 01c11000 {
>> -			compatible = "allwinner,sun5i-a13-mmc";
>> +			compatible = "allwinner,sun7i-a20-mmc";
>>  			reg = <0x01c11000 0x1000>;
>>  			clocks = <&ccu CLK_BUS_MMC2>,
>>  				 <&ccu CLK_MMC2>,
>>
