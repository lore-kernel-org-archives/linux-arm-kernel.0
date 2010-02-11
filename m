From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 11 Feb 2010 09:32:40 -0000 (GMT)
Subject: [PATCH] Eurotech Zeus : Making USB port 2 work
In-Reply-To: <20100211123344.28014152@ironhide>
References: <20100210120555.1b648467@ironhide>
	<37cba69b59077aff2450e9b89c9d0d20.squirrel@www.loen.fr>
	<20100211123344.28014152@ironhide>
Message-ID: <4b396ba26c3a8b9da558246363208a69.squirrel@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, February 11, 2010 07:03, Amit Walambe wrote:
> Hi!
> Thanks for your comments Marc.
>
> On Wed, 10 Feb 2010 09:38:38 -0000 (GMT)
> "Marc Zyngier" <maz@misterjones.org> wrote:
>> >  static struct pxaohci_platform_data zeus_ohci_platform_data = {
>> >  	.port_mode	= PMM_NPS_MODE,
>> > -	.flags		= ENABLE_PORT_ALL |
>> > POWER_CONTROL_LOW | POWER_SENSE_LOW,
>> > +	/* Clear Power Control Polarity Low and set Power Sense
>> > +	 * Polarity Low. Supply power to USB ports. */
>> > +	.flags		= ENABLE_PORT_ALL |
>> > ~(POWER_CONTROL_LOW) | POWER_SENSE_LOW,
>>
>> I suppose that is actually what makes it work, though the change is
>> rather suspect. You're basically setting *all* bits to 1
> My bad. Attaching a modified patch. I have tested it on a Zeus and it
> works ok.

Thanks. Both patches queued for 2.6.34.

        M.
-- 
And if you don't know where you're going, any road will take you there...
