From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 11 Jul 2015 18:39:10 +0100
Subject: [PATCH v2 2/2] ARM: dts: vfxxx: Add property for minimum sample
 time
In-Reply-To: <20150710180640.GB8723@Sanchayan-Arch>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
 <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com>
 <20150710085324.GL23464@tiger> <20150710180640.GB8723@Sanchayan-Arch>
Message-ID: <55A154BE.6000701@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/15 19:06, maitysanchayan at gmail.com wrote:
> Hello Shawn,
> 
> On 15-07-10 16:53:24, Shawn Guo wrote:
>> On Wed, Jun 24, 2015 at 02:03:41PM +0530, Sanchayan Maity wrote:
>>> Add a device tree property which allows to specify the minimum sample
>>> time which can be used to calculate the actual ADC cycles required
>>> depending on the hardware.
>>>
>>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
>>> index 90a03d5..71d9c08 100644
>>> --- a/arch/arm/boot/dts/vfxxx.dtsi
>>> +++ b/arch/arm/boot/dts/vfxxx.dtsi
>>> @@ -229,6 +229,7 @@
>>>  				status = "disabled";
>>>  				fsl,adck-max-frequency = <30000000>, <40000000>,
>>>  							<20000000>;
>>> +				min-sample-time = <1000>;
>>>  			};
>>>  
>>>  			wdoga5: wdog at 4003e000 {
>>> @@ -447,6 +448,7 @@
>>>  				status = "disabled";
>>>  				fsl,adck-max-frequency = <30000000>, <40000000>,
>>>  							<20000000>;
>>> +				min-sample-time = <1000>;
>>
>> Can we code 1000 as the default in kernel driver, so that only boards
>> requiring different value need to have this property?  Doing so makes
>> the property optional rather than required.
>>
> 
> Not sure if hardcoding it in the driver is the right approach.
If it is a true feature of the device (i.e. if in the case of perfect
front end electronics) this is the right option, then a default makes
a lot of sense.  If that isn't the case (I suspect not) then if we
drop it be optional chances are no one will bother thinking about it
or trying to tune this at all.

Hence seems wrong to put a fairly arbitrary default value on it.
However, we do need to still work with old device trees and new kernels
so need to cope without it.

Hence to my mind, if we had started out with this in the first driver
version, then the default would be a bad idea.  As we didn't then we
really need to cope with nothing specified (as best we can) and so
we do need a sensible default (or perhaps even sensible worst
case default) in there. 
> 
> However if the maintainers and others agree on doing this, I will do
> the necessary change.
> 
> Thanks.
> 
> Regards,
> Sanchayan.
> 
