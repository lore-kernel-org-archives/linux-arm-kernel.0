From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Mar 2013 15:42:43 +0100
Subject: [PATCH] ARM: mvebu: fix RAM size for Armada XP board DB-MV784MP-GP
In-Reply-To: <20130313143913.GN12700@titan.lakedaemon.net>
References: <20130216164457.GA23237@titan.lakedaemon.net>
 <1363101135-21635-1-git-send-email-jason@lakedaemon.net>
 <51408D86.6040703@cogentembedded.com>
 <20130313143913.GN12700@titan.lakedaemon.net>
Message-ID: <51409063.8080308@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 03:39 PM, Jason Cooper wrote:
> On Wed, Mar 13, 2013 at 06:30:30PM +0400, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 12-03-2013 19:12, Jason Cooper wrote:
>>
>>> The board is supplied with a 4GB RAM module.  This value can be
>>> overridden by the bootloader based on probed memory size.  We set it to
>>> a reasonable value here.
>>
>>> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>>> ---
>>> As promised, catching this fix in the -rc cycle.
>>
>>> For those not familiar, earlier versions of the patch adding this board listed
>>> 3GB because that is all that was visible.  I mistaken applied v3 of the patch
>>> instead of v4 which properly listed 4GB.  This patch cleans up my error.
>>
>>>  arch/arm/boot/dts/armada-xp-gp.dts | 9 ++++-----
>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>>> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
>>> index 1c8afe2..4a2776a 100644
>>> --- a/arch/arm/boot/dts/armada-xp-gp.dts
>>> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
>>> @@ -28,12 +28,11 @@
>>>  		device_type = "memory";
>>>
>>>  		/*
>>> -		 * 4 GB of plug-in RAM modules by default but only 3GB
>>> -		 * are visible, the amount of memory available can be
>>> -		 * changed by the bootloader according the size of the
>>> -		 * module actually plugged
>>> +		 * 4 GB of plug-in RAM modules by default. The amount of memory
>>> +		 * available can be changed by the bootloader according the
>>
>>    "According to the size".
> 
> ok.
> 
>>> +		 * size of the module actually plugged
>>>  		 */
>>> -		reg = <0x00000000 0xC0000000>;
>>> +		reg = <0x00000000 0xD0000000>;
>>
>>    But this is not 4G?
> 
> Interesting, this was the value given in v4 of the original patch adding
> this board.  I should have double-checked it. v2 on the way.
> 

I was wrong in my initial version, all we can do in 32 bits is not 4GB but 4GB-1B:
reg = <0x00000000 0xFFFFFFFF>

> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
