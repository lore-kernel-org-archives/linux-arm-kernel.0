From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Jan 2013 21:38:45 +0100
Subject: [PATCH] ARM: VIC: use irq_domain_add_simple()
In-Reply-To: <20130111185758.45FF73E215F@localhost>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
 <507D61E7.2080704@gmail.com>
 <CACxGe6tBLfj3CDDZAfGmznj3B-h4OfJsrRc+85w9fnxFH6Cd_Q@mail.gmail.com>
 <CACRpkdbtn4Pz3uLCxDGOBSVW7vfLECf2UZkT5+X9ip1ZZFb8Lw@mail.gmail.com>
 <20130111185758.45FF73E215F@localhost>
Message-ID: <CACRpkdaX7wO=x9K9V45QzJxi73-euvAqyrjA8L4cLGSPZck5og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 7:57 PM, Grant Likely <grant.likely@secretlab.ca> wrote:

>> Does the below patch work for you, it does two things:
>>
>> 1) Bump all Versatile IRQs to offset at 32, because it is using
>>   IRQ 0 which is NO_IRQ and illegal anyway so it's anyway
>>   a bug that should be fixed.
>>
>> 2) Make sure we call irq_create_mapping() if the start IRQ is
>>   anyway 0, as in the device tree case, and make sure to
>>   actually pass zero in that case.
>
> In actual fact, only changing the offset to 32 is required to get
> Versatile to boot with DT. That platform doesn't yet use vic_of_init().
> It currently depends on pre-allocated irq_descs.

OK both are already upstream, because there was someone
else verifying they solved the problem.

And the second patch was needed on the Integrator which
does use SPARSE_IRQ + vic_init_of().
Probably the DT-based SPEArs need it too.

Yours,
Linus Walleij
