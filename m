From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Jun 2017 15:14:41 +0100
Subject: [PATCH v3 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170620160956.361ed003@windsurf.lan>
References: <20170616141923.31226-1-thomas.petazzoni@free-electrons.com>
 <20170616141923.31226-5-thomas.petazzoni@free-electrons.com>
 <2934dbf3-e1f0-3997-ba70-3b6a7a2973d9@arm.com>
 <20170620154631.77a1f192@windsurf.lan>
 <7c5d8d75-1319-a9ae-856d-67813ad2e1c5@arm.com>
 <20170620160956.361ed003@windsurf.lan>
Message-ID: <15ee5379-9e4a-1b01-afce-0c87b1baf14d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 15:09, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 20 Jun 2017 15:00:19 +0100, Marc Zyngier wrote:
> 
>> There is a few things: this driver could (mostly) work with a GICv3
>> distributor (located way above 4GB) instead of the GICP, and I'd rather
>> make no assumption of where GICP is located in the memory map.
>>
>> So I'd rather see:
>>
>> 	if (msg->address_lo || msg->address_hi) {
>> 		[...]
>> 	} else {
>> 		/* deconfiguration case */
>> 	}
> 
> Ha, OK, indeed. /me feels stupid now.
> 
> Unfortunately, I just sent v4 a few minutes ago. I'll wait for you to
> look at this v4. If there's nothing else to be changed, then I'll send
> a v5 with just this change.

If that's the only thing, I can apply the fixlet locally.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
