From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jul 2013 09:11:32 +0100
Subject: Can't get FIQ interrupt to work on i.mx233
In-Reply-To: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
References: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
Message-ID: <20130716081132.GB24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 10:59:22AM +0900, Juha Lumme wrote:
> For now the assembly handler is only 6 instructions: http://codetidy.com/6193/
> I first want to just clear the interrupt bit in HW_ICOLL_INTERRUPT31,
> and then I write 0xFF to HW_PINCTRL_DOUT1

Unfortunately, the code doesn't match your description.  You set r10 to
0xff, and then _load_ the value from the address at r8 into r10.

Maybe that ldr r10, [r8] should be str r10, [r8] ?
