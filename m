From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 14 Jan 2015 15:44:39 -0800
Subject: [PATCH] ARM: dts: exynos5422-odroidxu3: add INA2xx sensors
In-Reply-To: <1421270704.2450.138.camel@collabora.co.uk> (Sjoerd Simons's
 message of "Wed, 14 Jan 2015 22:25:04 +0100")
References: <1421193801-24637-1-git-send-email-khilman@kernel.org>
 <1421270704.2450.138.camel@collabora.co.uk>
Message-ID: <7hy4p5orko.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sjoerd Simons <sjoerd.simons@collabora.co.uk> writes:

> Hey kevin,
>
> On Tue, 2015-01-13 at 16:03 -0800, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@linaro.org>
>> 
>> The odroid-xu3 has 4 INA231 current sensors on board which can be
>> accessed from the Linux via the hwmon interface.
>> 
>> There is one sensor for each of these power rails:
>> 
>> - A15 cluster: VDD_ARM
>> - A7 cluster: VDD_KFC
>> - GPU: VDD_G3D
>> - memory: VDD_MEM
>> 
>> In addition to adding the sensors, LDO26 from the PMIC needs to be
>> enabled because it's powering these sensor.
>> 
>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> ---
>> Applies on top of "ARM: dts: Add dts file for odroid XU3 board" from Sjoerd Simons.
>> 
>>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 39 ++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> index c29123c0734d..7874da20939f 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> @@ -257,6 +264,38 @@
>>  		};
>>  	};
>>  
>> +	i2c_0: i2c at 12C60000 {
>> +		status = "okay";
>> +
>> +		/* A15 cluster: VDD_ARM */
>> +		ina220 at 40 {
>                    ^ ina231 at 40 ?
>> +			compatible = "ti,ina230";
>
> This feels incredibly nitpicky, but would it not better to use ti,ina231
> as it's an INA231 chip not a INA230? (And add the compatibility string
> to the driver)

Hmm, you're right.  Until recently, I thought these were INA230s, but
squinted enough at the schematic yesterday to notice they were marked as
INA231, so updated the changelog, but not the DTS.

Will re-spin with a compatible string update to the driver.

Kevin
