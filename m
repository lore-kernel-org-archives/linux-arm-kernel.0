From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Nov 2014 18:18:46 +0100
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <CALT56yMVjRC4YhWsc9d_i0mVrHyv8XV=Sw2op=xsdR5izv1tHg@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sat, 22 Nov 2014 19:44:10
 +0400")
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
 <CALT56yO8tktrXo0rfRd91AtXBE4F5vYfYjm9AL+7dcoam6Oq9Q@mail.gmail.com>
 <87egsz6ija.fsf@free.fr> <87sihb49vm.fsf@free.fr>
 <CALT56yMVjRC4YhWsc9d_i0mVrHyv8XV=Sw2op=xsdR5izv1tHg@mail.gmail.com>
Message-ID: <87lhn340i1.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> 2014-11-22 16:56 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>> Okay, now my ADSL line is repaired, thank you Mr farmer "I drive a tractor but I
>>> don't care about telephone posts", I'll fetch your changes and make a
>>> test. Let's say I schedule this for saturday.
>>
>> Removed people from the list for the tests aspect.
>>
>> Well, my lubbock board seem to raise several interrupts in the linux kernel, all
>> the LUBBOCK_IRQ interrupts multiplexed on GPIO0 actually, amongst which are the
>> 2 interrupts for the UDC.
Arg, what I meant to write was "seem to *never* raise several interrupts".

> This looks normal - GPIO0 is connected to an interrupt pin of the CPLD.
> lubbock_init_irq function should be setting up a chained handler for the GPIO0.
> And that chained handler (lubbock_irq_handler) should further decode which
> IRQ bit is set. Do you see the handler being called? Can you print the (pending)
> variable in the handler?
lubbock_irq_handler() is never called.
pxa_gpio_demux_handler() is never called.
  => this is the one worrying me most.

And as the lubbock_irq_handler() is never called there is not point in printing
that yet, first should be finding out why on earth the gpio demux is not getting
called.

Cheers.

-- 
Robert
