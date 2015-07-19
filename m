From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 19 Jul 2015 13:44:55 +0100
Subject: [PATCH v3 2/2] ARM: dts: vf-colibri: Add property for minimum
 sample time
In-Reply-To: <c84f141e3e222a48b6adf52e686df7e9@agner.ch>
References: <cover.1436880513.git.maitysanchayan@gmail.com>
 <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com>
 <20150715015725.GK4119@tiger> <c84f141e3e222a48b6adf52e686df7e9@agner.ch>
Message-ID: <55AB9BC7.9040408@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/15 14:02, Stefan Agner wrote:
> On 2015-07-15 03:57, Shawn Guo wrote:
>> On Tue, Jul 14, 2015 at 07:23:23PM +0530, Sanchayan Maity wrote:
>>> Add a device tree property which allows to specify the minimum sample
>>> time which can be used to calculate the actual ADC cycles required
>>> depending on the hardware.
>>>
>>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
>>> index ab10d2e..59f5deb 100644
>>> --- a/arch/arm/boot/dts/vf-colibri.dtsi
>>> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
>>> @@ -16,10 +16,12 @@
>>>  };
>>>
>>>  &adc0 {
>>> +	min-sample-time = <1000>;
>>>  	status = "okay";
>>>  };
>>>
>>>  &adc1 {
>>> +	min-sample-time = <1000>;
>>
>> Since this is the default value anyway, we can just save the patch,
>> right?
> 
> I thought it would be nice to be explicit here and define this value
> which we verified internally.
> 
> On the other hand, we did not derived the minimum value from the DS
> (using the capacity/resistance of the actual analog source connected) to
> maximize the sampling frequency, hence I'm also ok with not explicitly
> defining a value.
I'll drop this patch then and we are all happy (I think)
> 
> --
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
