From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Mar 2015 09:34:23 +0100
Subject: [PATCH] pinctrl: at91: move lock/unlock_as_irq calls into
 request/release resources methods
In-Reply-To: <CACRpkdazTt+_9m-iWEee2gJy4MQ+QNo3Rb2JY9hVSSXK2-dJRw@mail.gmail.com>
References: <1423419822-6258-1-git-send-email-boris.brezillon@free-electrons.com>
 <CACRpkdazTt+_9m-iWEee2gJy4MQ+QNo3Rb2JY9hVSSXK2-dJRw@mail.gmail.com>
Message-ID: <54FEAC8F.1040206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/03/2015 17:14, Linus Walleij a ?crit :
> On Sun, Feb 8, 2015 at 7:23 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> 
>> The gpiochip_lock_as_irq call can fail and return an error, while the
>> irq_startup is not expected to fail (returns an unsigned int which is not
>> checked by irq core code).
>>
>> irq_request/release_resources functions have been created to address this
>> problem.
>>
>> Move gpiochip_lock/unlock_as_irq calls into
>> irq_request/release_resources functions to prevent using a gpio as an irq
>> if the gpiochip_lock_as_irq call failed.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Patch applied with all the ACKs.

Hi Linus,

As suggested earlier, do you think it can be scheduled for the 4.0-rc
phase as a "fix"?

Bye,



> Happy new year J-C!
> 
> Yours,
> Linus Walleij
> 
> 


-- 
Nicolas Ferre
