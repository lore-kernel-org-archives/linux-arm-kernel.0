From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 10:28:15 -0700
Subject: [PATCH v2 03/10] ARM: dt: tegra30: Add clock information
In-Reply-To: <50F65E4B.8040409@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
 <1357891289-23500-3-git-send-email-pgaikwad@nvidia.com>
 <50F65E4B.8040409@nvidia.com>
Message-ID: <50F6E32F.80602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 01:01 AM, Terje Bergstr?m wrote:
> On 11.01.2013 10:01, Prashant Gaikwad wrote:
>> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
>> index 6765646..c3e129a 100644
>> --- a/arch/arm/boot/dts/tegra30.dtsi
>> +++ b/arch/arm/boot/dts/tegra30.dtsi
>>  		gr3d {
>>  			compatible = "nvidia,tegra30-gr3d";
>>  			reg = <0x54180000 0x00040000>;
>> +			clocks = <&tegra_car 24>;
>>  		};
> 
> In Tegra3, 3D has two clocks. I believe you'd need to add <&tegra_car
> 98> here.

Thanks. I've squashed the following into the patch. Do those clock names
make sense to you?

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index b9709ae..c26d75b 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -54,7 +54,8 @@
                gr3d {
                        compatible = "nvidia,tegra30-gr3d";
                        reg = <0x54180000 0x00040000>;
-                       clocks = <&tegra_car 24>;
+                       clocks = <&tegra_car 24 &tegra_car 98>;
+                       clock-names = "3d", "3d2";
                };

                dc at 54200000 {
