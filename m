From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Thu, 16 Jul 2015 10:18:38 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdb_3B8749X-p_XEPGvZPEQ56-gMdLBcPrgjXkqWCiz1PQ@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
 <20150702142058.GA9349@localhost.localdomain>
 <CACRpkdb_3B8749X-p_XEPGvZPEQ56-gMdLBcPrgjXkqWCiz1PQ@mail.gmail.com>
Message-ID: <C83A636F-4C5C-4C11-A3CA-B4C4624B5375@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16 Jul 2015, at 9:57 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> On Thu, Jul 2, 2015 at 4:20 PM, Richard Cochran
> <richardcochran@gmail.com> wrote:
>> On Thu, Jul 02, 2015 at 08:05:26AM +0100, Michael van der Westhuizen wrote:
> 
>> Anyhow, the whole point is, when the data sheet says that the SoC has
>> GPIO0 to GPION, then those numbers should be exposed to user space.
> 
> The gpio_chip has this:
> 
> struct gpio_chip {
>        const char              *label;
>        struct device           *dev;
> (...)
>        const char              *const *names;
> (...)
> 
> If you want to help the users, provide string names for all the GPIO lines
> and suggest them to do code in userspace that use these names instead
> of GPIO numbers.
> 
> Also the string names "gpio0", "gpio1" etc are much better than just using
> the Linux-specific numbers.
> 
> So what about making a patch to drivers/gpio/gpio-dwapb.c that adds the
> .names property to its GPIO chip?

That would meet my needs.  I?ll start putting something together.

Michael
