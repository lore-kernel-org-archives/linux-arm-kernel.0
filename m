From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 18 Jul 2013 15:19:12 +0100
Subject: Can't get FIQ interrupt to work on i.mx233
In-Reply-To: <51E69F42.2060106@gmail.com>
References: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
 <20130716081132.GB24642@n2100.arm.linux.org.uk>
 <51E5322B.8080602@gmail.com>
 <20130716161643.GB3428@localhost.localdomain>
 <51E69F42.2060106@gmail.com>
Message-ID: <20130718141905.GA2655@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:42:26PM +0900, Juha Lumme wrote:
> Hi Dave,
> 
> Thanks for the idea, that's indeed a dead simple way to find out.
> Being sure that I will get stuck in FIQ handler, I started
> experimenting different things, and it seems that if instead of
> calling mxs_icoll_set_irq_fiq(31) (which only sets FIQ bit), I
> directly set bits 4 (FIQ) and 2 (ENABLE) in HW_ICOLL_INTERRUPT31
> register, my interrupt starts working as expected. Maybe I can also
> leave enable_fiq out this way.
> 
> So it currently seems like mxs_icoll_set_irq_fiq (which I patched
> in) and enable_fiq (already there) are not working as expected
> currently in freescale's mainline 3.10.
> I will try to find out the reason, and create patches for this - but
> if you have any pointers on what might help me on a right path, I
> would appreciate it.

It sounds like you're on the right track -- I can't comment on the
details though, since I'm not familiar with this board.

Cheers
---Dave
