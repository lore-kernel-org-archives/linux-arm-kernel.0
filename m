From: stefan@agner.ch (Stefan Agner)
Date: Fri, 15 May 2015 18:01:19 +0200
Subject: [PATCH v6 04/12] irqchip: vf610-mscm: support NVIC parent
In-Reply-To: <alpine.DEB.2.11.1505151237531.4225@nanos>
References: <1431203982-13217-1-git-send-email-stefan@agner.ch>
 <1431203982-13217-5-git-send-email-stefan@agner.ch>
 <alpine.DEB.2.11.1505151237531.4225@nanos>
Message-ID: <6af49d55159182668c21480e0fbaa85c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-15 12:39, Thomas Gleixner wrote:
> On Sat, 9 May 2015, Stefan Agner wrote:
>> -	irq_chip_unmask_parent(data);
>> +	if (parent->chip->irq_enable)
>> +		parent->chip->irq_enable(parent);
>> +	else
>> +		parent->chip->irq_unmask(parent);
> 
> Why are you not creating irq_chip_enable_parent() which would have
> been the proper function anyway?
> 

Will add that...

Btw, have you had a chance to look at 1/12? I added a helper there too
to allow make use of generic chip with IRQ domain hierarchy. In case you
are fine with that general appraoch I will send an updated version of
the patchset with the irq_chip_enable_parent helper soon. 

--
Stefan
