From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Aug 2011 22:25:55 +0200
Subject: [RFC PATCH 0/3] If an IRQ is a GPIO, request and configure it
In-Reply-To: <20110805103045.GG28651@trinity.fluff.org>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<20110805094017.GC20575@n2100.arm.linux.org.uk>
	<20110805103045.GG28651@trinity.fluff.org>
Message-ID: <CACRpkdai55JSN+dkaYu96FTDDVSa8bHZFkBS6M1u3gPUDmpE_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2011 at 12:30 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Aug 05, 2011 at 10:40:17AM +0100, Russell King - ARM Linux wrote:
>> Trying to go from IRQ to GPIO is not a good idea - most of the
>> IRQ <-> GPIO macros we have today are just plain broken. ?Many of them
>> just add or subtract a constant, which means non-GPIO IRQs have an
>> apparant GPIO number too. ?Couple this with the fact that all positive
>> GPIO numbers are valid, and this is a recipe for wrong GPIOs getting
>> used and GPIOs being requested for non-GPIO IRQs.
>
> Yes, and there's a pile without these defined/

And I'm piling a few patches *deleting* irq_to_gpio() from platforms that
define but actually don't use it, like U300 and SA1100.

Linus Walleij
