From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Jul 2013 14:52:51 +0200
Subject: [PATCH v3 07/13] ARM: dts: Add AK8975 device node for Exynos4412
 TRATS2 board
In-Reply-To: <1491290.c836bFtNe2@flatron>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
 <1372692155-17653-8-git-send-email-s.nawrocki@samsung.com>
 <1491290.c836bFtNe2@flatron>
Message-ID: <51DAB623.1010404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 07/06/2013 01:18 AM, Tomasz Figa wrote:
> On Monday 01 of July 2013 17:22:29 Sylwester Nawrocki wrote:
>> From: Jacek Anaszewski <j.anaszewski@samsung.com>
>>
>> This patch adds AK8975 magnetometer node and corresponding
>> i2c-gpio bus node for TRATS2 board.
>>
>> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4412-trats2.dts |   19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts
>> b/arch/arm/boot/dts/exynos4412-trats2.dts index 056b835..b9de3b5 100644
>> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
>> @@ -19,6 +19,10 @@
>>  	model = "Samsung Trats 2 based on Exynos4412";
>>  	compatible = "samsung,trats2", "samsung,exynos4412";
>>
>> +	aliases {
>> +		i2c8 = &i2c_ak8975;
>> +	};
>> +
>>  	memory {
>>  		reg =  <0x40000000 0x40000000>;
>>  	};
>> @@ -453,4 +457,19 @@
>>  	serial at 13830000 {
>>  		status = "okay";
>>  	};
>> +
>> +	i2c_ak8975: i2c-gpio at 0 {
> 
> I think this @0 is slightly incorrect here, as it seems like there is no 
> reg property present inside the node and so the device isn't located at 
> any address.
> 
> For logical indices like in this case I would rather use i2c-gpio-0 
> instead.

Indeed, using "-<N>" postfix sounds like a better alternative. I'll change
it and repost the series after 3.11-rc1 is released.

>> +		compatible = "i2c-gpio";
>> +		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
>> +		i2c-gpio,delay-us = <2>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		status = "okay";
>> +
>> +		ak8975 at 0c {
>> +			compatible = "asahi-kasei,ak8975";
>> +			reg = <0x0c>;
>> +			gpios = <&gpj0 7 0>;
>> +		};
>> +	};
>>  };
> 
> Otherwise looks good.
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Thanks,
Sylwester
