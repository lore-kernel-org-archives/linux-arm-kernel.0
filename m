From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 13 Aug 2014 10:52:18 +0300
Subject: [PATCH 2/3] ARM: tegra: Add PMC thermtrip programming to Jetson
 TK1 device tree
In-Reply-To: <20140813073736.GB17466@ulmo>
References: <1407226380-747-1-git-send-email-mperttunen@nvidia.com>
 <1407226380-747-3-git-send-email-mperttunen@nvidia.com>
 <20140813073736.GB17466@ulmo>
Message-ID: <53EB1932.9040601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/14 10:37, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Tue, Aug 05, 2014 at 11:12:59AM +0300, Mikko Perttunen wrote:
>> This adds the required information to reset the board during an overheating
>> situation to the Jetson TK1 device tree. The thermal reset is handled by the
>> PMC by sending an I2C message to the PMIC. The entries specify the I2C
>> message to be sent.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> index 624b0fb..ee178c4 100644
>> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> @@ -1617,6 +1617,11 @@
>>   		nvidia,core-pwr-off-time = <61036>;
>>   		nvidia,core-power-req-active-high;
>>   		nvidia,sys-clock-req-active-high;
>> +
>> +		nvidia,thermtrip-pmu-i2c-addr = <0x40>;
>> +		nvidia,thermtrip-i2c-controller = <4>;
>> +		nvidia,thermtrip-reg-addr = <0x36>;
>> +		nvidia,thermtrip-reg-data = <0x2>;
>
> Given the number of properties that this can potentially have, I wonder
> if perhaps it would be a good idea to put this into a subnode, like
> this:
>
> 		thermtrip {
> 			pmu-i2c-addr = <0x40>;
> 			i2c-controller = <4>;
> 			...
> 		};

I guess that'd look a bit nicer.

>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
>

Mikko
