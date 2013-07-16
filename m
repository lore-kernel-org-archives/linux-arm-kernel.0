From: juha.lumme@gmail.com (Juha Lumme)
Date: Tue, 16 Jul 2013 20:44:43 +0900
Subject: Can't get FIQ interrupt to work on i.mx233
In-Reply-To: <20130716081132.GB24642@n2100.arm.linux.org.uk>
References: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
 <20130716081132.GB24642@n2100.arm.linux.org.uk>
Message-ID: <51E5322B.8080602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Thanks for your reply.
And thanks for pointing out the wrong instruction there with the ldr 
instruction.

However, unfortunately the code still doesn't seem to trigger anything 
(neither to clear the IRQ bit in the timer, nor the GPIO output).. It 
seems to me as if the handler never gets called. Is there a good way to 
confirm that any activity is actually triggered when timer3 reaches 0, 
and the IRQ bit is set to 1 ?

Best regards,
Juha

On 07/16/2013 05:11 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 16, 2013 at 10:59:22AM +0900, Juha Lumme wrote:
>> For now the assembly handler is only 6 instructions: http://codetidy.com/6193/
>> I first want to just clear the interrupt bit in HW_ICOLL_INTERRUPT31,
>> and then I write 0xFF to HW_PINCTRL_DOUT1
> Unfortunately, the code doesn't match your description.  You set r10 to
> 0xff, and then _load_ the value from the address at r8 into r10.
>
> Maybe that ldr r10, [r8] should be str r10, [r8] ?
