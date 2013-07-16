From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 16 Jul 2013 17:16:43 +0100
Subject: Can't get FIQ interrupt to work on i.mx233
In-Reply-To: <51E5322B.8080602@gmail.com>
References: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
 <20130716081132.GB24642@n2100.arm.linux.org.uk>
 <51E5322B.8080602@gmail.com>
Message-ID: <20130716161643.GB3428@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 08:44:43PM +0900, Juha Lumme wrote:
> Hi Russel,
> 
> Thanks for your reply.
> And thanks for pointing out the wrong instruction there with the ldr
> instruction.
> 
> However, unfortunately the code still doesn't seem to trigger
> anything (neither to clear the IRQ bit in the timer, nor the GPIO
> output).. It seems to me as if the handler never gets called. Is
> there a good way to confirm that any activity is actually triggered
> when timer3 reaches 0, and the IRQ bit is set to 1 ?
> 

A brutal, but simple, way to confirm that your handler is being called
is to try putting an infinite loop in there:

	b	.

If your board then locks up, the handler is almost certainly getting
called.

Cheers
---Dave
