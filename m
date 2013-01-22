From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Jan 2013 10:09:03 +0100
Subject: [PATCH 1/6] arm: mvebu: Add support for local interrupt
In-Reply-To: <20130121232637.GA3412@localhost>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-2-git-send-email-gregory.clement@free-electrons.com>
 <20130121191744.0a04b941@skate> <50FDBC0E.1030706@free-electrons.com>
 <20130121232637.GA3412@localhost>
Message-ID: <50FE572F.4090402@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 12:26 AM, Ezequiel Garcia wrote:
> Hi Thomas and Gregory,
> 
> On Mon, Jan 21, 2013 at 11:07:10PM +0100, Gregory CLEMENT wrote:
>> On 01/21/2013 07:17 PM, Thomas Petazzoni wrote:
>>>> +		irq_set_percpu_devid(virq);
>>>> +		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>>>> +					handle_percpu_devid_irq);
>>>> +
>>>> +	} else {
>>>> +		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>>>> +					handle_level_irq);
>>>> +	}
>>>
>>> Braces useless since there is only one statement in the else.
>>>
> 
> IMHO, this is an exception to the rule.
> Since the first block is more than one line,
> we usually put braces on the single line block too.
> (or at least that's what Documentation/CodingStyle says).
> 

You're right!
I would have liked to say I have done it on purpose, but in fact these
braces are here only because during development I had had multiples lines
inside the else.
However, as you pointed it, I will keep it.

> Regards,
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
