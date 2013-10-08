From: nm@ti.com (Nishanth Menon)
Date: Tue, 8 Oct 2013 13:01:26 -0500
Subject: [PATCH 2/2] ARM: dts: omap3-beagle: use 3630 definitions
In-Reply-To: <20131008174721.GH13128@radagast>
References: <523C9D8B.2000701@ti.com>
 <1381164584-4008-1-git-send-email-nm@ti.com>
 <1381164584-4008-3-git-send-email-nm@ti.com>
 <20131007192009.GA8949@atomide.com> <20131008174721.GH13128@radagast>
Message-ID: <52544876.8000904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 12:47 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Oct 07, 2013 at 12:20:09PM -0700, Tony Lindgren wrote:
>> * Nishanth Menon <nm@ti.com> [131007 09:57]:
>>> beagle-xm currently would matchup with ti,omap3 which invokes
>>> omap3430_init_early instead of omap3630_init_early. So add
>>> compatiblity for 3630 to allow match
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>>> index 0f7cfc5..2079e22 100644
>>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>>> @@ -11,7 +11,7 @@
>>>  
>>>  / {
>>>  	model = "TI OMAP3 BeagleBoard xM";
>>> -	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
>>> +	compatible = "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3-beagle", "ti,omap3";
>>>  
>>>  	cpus {
>>>  		cpu at 0 {
>>
>> This compatible string looks hacky.. How about just make it
>>
>> "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3";
>>
>> How about just leave out "ti,omap3-beagle" here?
> 
> ti,omap3-beagle was already part of the original file, we can definitely
> remove but I'd expect us to maintain support for that string
> indefinitely should anybody continue to use older dtbs.
> 
it already is supported (we still have a beagleboard) - the current
patch rev does nothing to break existing code or bindings.

-- 
Regards,
Nishanth Menon
