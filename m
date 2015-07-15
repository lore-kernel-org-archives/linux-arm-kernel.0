From: stefan@agner.ch (Stefan Agner)
Date: Wed, 15 Jul 2015 15:02:35 +0200
Subject: [PATCH v3 2/2] ARM: dts: vf-colibri: Add property for minimum
 sample time
In-Reply-To: <20150715015725.GK4119@tiger>
References: <cover.1436880513.git.maitysanchayan@gmail.com>
 <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com>
 <20150715015725.GK4119@tiger>
Message-ID: <c84f141e3e222a48b6adf52e686df7e9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-15 03:57, Shawn Guo wrote:
> On Tue, Jul 14, 2015 at 07:23:23PM +0530, Sanchayan Maity wrote:
>> Add a device tree property which allows to specify the minimum sample
>> time which can be used to calculate the actual ADC cycles required
>> depending on the hardware.
>>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> ---
>>  arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
>> index ab10d2e..59f5deb 100644
>> --- a/arch/arm/boot/dts/vf-colibri.dtsi
>> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
>> @@ -16,10 +16,12 @@
>>  };
>>
>>  &adc0 {
>> +	min-sample-time = <1000>;
>>  	status = "okay";
>>  };
>>
>>  &adc1 {
>> +	min-sample-time = <1000>;
> 
> Since this is the default value anyway, we can just save the patch,
> right?

I thought it would be nice to be explicit here and define this value
which we verified internally.

On the other hand, we did not derived the minimum value from the DS
(using the capacity/resistance of the actual analog source connected) to
maximize the sampling frequency, hence I'm also ok with not explicitly
defining a value.

--
Stefan
