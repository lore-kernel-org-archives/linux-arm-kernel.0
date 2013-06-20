From: rogerq@ti.com (Roger Quadros)
Date: Thu, 20 Jun 2013 14:55:29 +0300
Subject: [RFC PATCH 5/6] ARM: dts: omap3beagle-xm: Add idle state pins
 for USB host
In-Reply-To: <87obb26ixm.fsf@linaro.org>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-6-git-send-email-rogerq@ti.com> <87obb26ixm.fsf@linaro.org>
Message-ID: <51C2EDB1.3080801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2013 09:42 PM, Kevin Hilman wrote:
> Roger Quadros <rogerq@ti.com> writes:
> 
>> Add the Idle state pins for USB host and enable WAKEUP on
>> DIR, DAT0-3, so that the PHY can wakeup the OMAP SoC from
>> sleep on any USB activity (e.g. remote wakeup or connect/disconnect).
>>
>> CC: Beno?t Cousson <b-cousson@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> This one doesn't apply...
> 
>> ---
>>  arch/arm/boot/dts/omap3-beagle-xm.dts |   29 +++++++++++++++++++++++------
>>  1 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> index d3808ed..f1d56c2 100644
>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> @@ -89,12 +89,7 @@
>>  };
>>  
>>  &omap3_pmx_core {
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <
>> -			&hsusbb2_pins
>> -	>;
>> -
>> -	hsusbb2_pins: pinmux_hsusbb2_pins {
> 
> This omap3_pmx_core section doesn't exist upstream in the xM DTS file
> (but does in omap3-beagle.dts.)  
> 
> Is there a dependency patch missing?
> 

Sorry for not mentioning it earlier. This is based on Benoit's tree [1]
and you need these patches

http://thread.gmane.org/gmane.linux.drivers.devicetree/38383

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
	/for_3.11/dts

cheers,
-roger
