From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 12 Jun 2012 13:02:05 -0500
Subject: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
Message-ID: <4FD7841D.1000202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/12/2012 03:30 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 02:27:09, Hunter, Jon wrote:
> 
>>> +static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
>>> +						struct resource *res)
> 
>>> +	return 1;
>>> +}
>>
>> Nit-pick, CodingStyle chapter 16 states that 0 should be used for
>> success when returning from a function.
> 
> I doubt whether this falls to the category you are referring.
> This function returns number of resources setup, please see
> similar for irq too, there it can be 2 also, success or failure
> is not sufficient for the other, and with this we have both
> functions returning values similar way.

Well looking at the function it seems that you either return an error
code or 1. So if you are never going to return anything other than 1 on
success it may as well be 0.

>>> +static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
>>> +{
>>> +	return bitmask;
>>> +}
>>
>> I have to ask what is the value in this helper function? ;-)
> 
> It is to stress the fact that flag user is passing need not be
> same as irq bit (here both have same value), this kind of an
> arrangement would be required later if waitpin interrupt also
> has to be handled, do you still prefer removing it now ?

I don't have strong feelings, but if you are not planning to add support
for the wait pin irq anytime soon I would leave it out.

Jon
