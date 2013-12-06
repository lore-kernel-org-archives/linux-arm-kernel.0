From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 10:36:57 -0700
Subject: [PATCH 1/4] ARM: tegra: add I2C controllers to Tegra124 DT
In-Reply-To: <20131206140333.GE30960@ulmo.nvidia.com>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
 <20131206140333.GE30960@ulmo.nvidia.com>
Message-ID: <52A20B39.7010703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 07:03 AM, Thierry Reding wrote:
> On Wed, Dec 04, 2013 at 03:26:53PM -0700, Stephen Warren wrote:
> [...]
>> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> [...]
>> @@ -176,6 +176,96 @@
>>  		status = "disabled";
>>  	};
>>  
>> +	i2c at 7000c000 {
>> +		compatible = "nvidia,tegra114-i2c";
> 
> Aren't we supposed to always list the most specific compatible as well,
> just in case we ever need to implement a specific quirk in the future?
> 
> So this would become:
> 
> 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";

Oops yes, I'll fix that up.
