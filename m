From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 18 Apr 2011 15:32:55 -0500
Subject: genirq: Implement a generic interrupt chip
In-Reply-To: <alpine.LFD.2.00.1104182142560.2744@localhost6.localdomain6>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.117340150@linutronix.de>
	<0D753D10438DA54287A00B027084269764D221CC64@AUSP01VMBX24.collaborationhost.net>
	<alpine.LFD.2.00.1104182130470.2744@localhost6.localdomain6>
	<alpine.LFD.2.00.1104182142560.2744@localhost6.localdomain6>
Message-ID: <0D753D10438DA54287A00B027084269764D22A5CBF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 18, 2011 12:44 PM, Thomas Gleixner wrote:
> On Mon, 18 Apr 2011, Thomas Gleixner wrote:
>
>> On Mon, 18 Apr 2011, H Hartley Sweeten wrote:
>>> On Saturday, April 16, 2011 2:14 PM, Thomas Gleixner wrote:
>>>> +void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
>>>> +			    unsigned int clr, unsigned int set)
>>>> +{
>>>> +	struct irq_chip_type *ct = gc->chip_types;
>>>> +	unsigned int i;
>>>> +
>>>> +	/* Init mask cache */
>>>> +	if (ct->irq_mask == irq_gc_mask_clr_bit ||
>>>> +	    ct->irq_mask == irq_gc_mask_set_bit)
>>> 
>>> struct irq_chip_type does not have a member named 'irq_mask'
>>
>> Found that already. Needs to be ct->chip_types->irq_mask of course.
>
> Gah, my brain is seriously damaged from staring into that
> code. ct->chip.irq_mask of course.

OK. With that fix, I compiled and boot tested these patches on an 
ep93xx based board:

genirq: Implement a generic interrupt chip
vic: Use generic interrupt chip

I do not have CONFIG_PM enabled so I'm not sure about the vic_id++
issue I pointed out earlier in vic: Use generic interrupt chip.

Other than that, for these two patches you can add (if you wish):

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
