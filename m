From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 25 Oct 2011 12:43:55 +0530
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111025072003.GF2119@S2100-06.ap.freescale.net>
References: <4EA4FF6B.2080906@ti.com>
	<20111024081706.GC8708@ponder.secretlab.ca>
	<20111024090228.GA1755@S2100-06.ap.freescale.net>
	<4EA52851.8000203@ti.com>
	<20111024091158.GB1755@S2100-06.ap.freescale.net>
	<4EA52C56.3080908@ti.com>
	<20111024134727.GF1755@S2100-06.ap.freescale.net>
	<4EA65073.7050205@ti.com>
	<20111025065216.GD2119@S2100-06.ap.freescale.net>
	<4EA65D81.6030109@ti.com>
	<20111025072003.GF2119@S2100-06.ap.freescale.net>
Message-ID: <4EA661B3.6010006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 October 2011 12:50 PM, Shawn Guo wrote:
> On Tue, Oct 25, 2011 at 12:26:01PM +0530, Rajendra Nayak wrote:
>> On Tuesday 25 October 2011 12:22 PM, Shawn Guo wrote:
>>> On Tue, Oct 25, 2011 at 11:30:19AM +0530, Rajendra Nayak wrote:
> [...]
>>>> Thats what we did for OMAP, and hence we always have the of_node
>>>> populated when the regulator devices are probed.
>>>> See this patch from Benoit on how thats done for twl devices..
>>>> http://marc.info/?l=linux-omap&m=131489864814428&w=2
>>>>
>>> OMAP is "Case 1", and we are talking about "Case 2".
>>
>> I don't see why it wouldn't work for "Case 2".
>
> I did not say it wouldn't work for "Case 2".  I meant they work in
> different way.
>
>> The only difference
>> is in case of "Case 1", the dev->of_node would already point to
>> the right regulator node, like 'reg1', 'reg2' above.
>> In case of "Case 2", the dev->of_node would point to the 'regulators'
>> node instead, and the driver could then do a for_each_child_of_node()
>> to iterate over all its children to get 'reg1', 'reg2' etc.
>>
> Yes, that's the difference.  So you will need to distinguish these
> two cases in regulator_register()?  How?

You don't need to distinguish these cases in regulator_register().
The driver knows if its handling "Case 1" devices or "Case 2" devices
and it needs to handle things accordingly and pass the right of_node
which regulator_register() can then attach to regulator_dev->dev.

>
