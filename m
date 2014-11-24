From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 24 Nov 2014 08:53:26 +0100
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <CALT56yMUQDZV5=dn_Hm7jNS5NQXj7ewXcB2LsGvTbCOuoio7JQ@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sat, 22 Nov 2014 21:51:20
 +0400")
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
 <CALT56yO8tktrXo0rfRd91AtXBE4F5vYfYjm9AL+7dcoam6Oq9Q@mail.gmail.com>
 <87egsz6ija.fsf@free.fr> <87sihb49vm.fsf@free.fr>
 <CALT56yMVjRC4YhWsc9d_i0mVrHyv8XV=Sw2op=xsdR5izv1tHg@mail.gmail.com>
 <87lhn340i1.fsf@free.fr>
 <CALT56yP1OGWQd5i+H+4uFkZD4AqdtF7J1+Lme76UgLgVfycQ4w@mail.gmail.com>
 <87h9xr3z35.fsf@free.fr>
 <CALT56yMUQDZV5=dn_Hm7jNS5NQXj7ewXcB2LsGvTbCOuoio7JQ@mail.gmail.com>
Message-ID: <87d28d3uh5.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> 2014-11-22 20:49 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Next point would be (from my POV) to make sure that
> lubbock_unmask_irq() is called
> and works as expected.

Actually the problem is probably within the CPLD.
Irrespective of the CPLD register LUB_IRQ_MASK_EN, the GPIO0 is always low,
indicating an interrupt all the time.

The only thing that changes that is the switch SW13, which forces GPIO0 to high,
but prevents interrupts.

Normally, GPIO0 = (SW13 | ! (LUB_IRQ_MASK_EN && LUB_IRQ_SET_CLR))

This is why I don't have any interrupt, next stage will be to verify U46 and U54
on the IO board for GPIO_INT# and USB_INT# signals ...

Cheers.

-- 
Robert
