From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Jun 2011 14:46:36 +0100
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <4E009A1E.1080903@gmail.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de> <4DFB8E20.60802@gmail.com>
	<4E007CEB.6040104@arm.com> <4E0093CF.6030804@gmail.com>
	<4E009679.4010206@arm.com> <4E009A1E.1080903@gmail.com>
Message-ID: <4E00A0BC.1090203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/11 14:18, Rob Herring wrote:
> On 06/21/2011 08:02 AM, Marc Zyngier wrote:
>> On 21/06/11 13:51, Rob Herring wrote:
>>> Marc,
>>>
>>> On 06/21/2011 06:13 AM, Marc Zyngier wrote:
>>>> On 17/06/11 18:25, Rob Herring wrote:
>>>>> Also, device tree support for early platform devices would be useful for
>>>>> this.
>>>>
>>>> What about the attached patch? I've used it to boot a VExpress board
>>>> with the following DT snippet (and the corresponding support in the
>>>> amp_smp_twd driver):
>>>>
>>>> 	localtimer at 2c000600 {
>>>> 		device_type = "localtimer";
>>>
>>> My understanding is device_type is only supposed to be used for devices
>>> with real OpenFirmware. You could just add localtimer or timer as a 2nd
>>> compatible string. I think localtimer is a bit of a Linux name, so just
>>> timer may be better.
>>
>> Using "compatible" would not work. You'd have to add the same compatible
>> string to all drivers, and get drivers probing the wrong device. Any
>> other property we could use instead?
> 
> No, I'm saying you have a compatible property like this:
> 
> compatible = "arm,smp-twd", "timer";
> 
> You create the early platform device(s) based on matches with "timer",
> but match the driver based on "arm,smp-twd".

Right. What about the attached patch? Test-booted on the same VE with
the above "compatible" property.

	M.
-- 
Jazz is not dead. It just smells funny...
