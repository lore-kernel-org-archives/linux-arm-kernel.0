From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 18 Feb 2013 13:58:08 +0530
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED22A16@DBDE01.ent.ti.com>
References: <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk> <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
 <alpine.LFD.2.03.1302160035240.6419@syhkavp.arg> <511F1DB4.8030400@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ED22A16@DBDE01.ent.ti.com>
Message-ID: <5121E618.1040304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013 01:38 PM, Bedia, Vaibhav wrote:
> On Sat, Feb 16, 2013 at 11:18:36, Shilimkar, Santosh wrote:
> [...]
>>>>
>>>> For the duplicate ioremapping, I don't think there's any need to
>>>> do it if we get things right.
>>>
>>> Note that if the ioremap matches a static map area there is no cost to
>>> ioremap it multiple times.
>>>
>>>
>> Thats true though now on OMAP we removed most of the static mappings.
>> The main issue is waste of IO space because, we end up mapping same
>> area two times for all the OMAP drivers. This can be optimized with
>> a arch ioremap caller hook but as discussed here, its nice to have
>> rather than something important.
>>
>
Mostly L3 and L4 OCP slaves ones are covered because of L3/L4 map.
If you boot a full blown kernel, you will see many dynamically allocated 
as well.

Regards,
Santosh
