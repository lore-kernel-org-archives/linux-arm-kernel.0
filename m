From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 10:33:23 +0200
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
In-Reply-To: <20140701122717.GN23300@sirena.org.uk>
References: <1404215726-2480-1-git-send-email-broonie@kernel.org>
 <20140701120622.GJ32514@n2100.arm.linux.org.uk>
 <20140701121142.GM23300@sirena.org.uk>
 <CAAVeFuJqRW0ih8Mg9MFwLf=wQ7eVK5+pm8deW0vTUdozJ16FfQ@mail.gmail.com>
 <20140701122717.GN23300@sirena.org.uk>
Message-ID: <CACRpkdZ7ai0AShAen=AkaorHt0ObhYCDC-OuHG-9nVb3LLt3KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 2:27 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 01, 2014 at 09:24:22PM +0900, Alexandre Courbot wrote:
>> On Tue, Jul 1, 2014 at 9:11 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Huh, good point (though it still seems a bit neater to match up the
>> > request and release functions I guess).  Linus?
>
>> Yeah it's a nice habit to free the GPIOs using the same interface as
>> the one used to obtain them. Although if we are to allow the regulator
>> framework to request GPIO through both the integer and descriptor
>> interfaces, we certainly don't want to track that information forever.
>
>> On top of that we want to limit the use of gpio_to_desc() and
>> desc_to_gpio() in drivers as much as possible, so I'd say I prefer to
>> see gpiod_free() used no matter where the GPIO came from.
>
> Right, but Linus said we didn't need this conversion to descriptors so
> I'm a bit confused as to what the issue he was raising was.

Now I'm probably confusing myself...

All drivers should as far as possible use descriptors internally, doing
things like gpio_to_desc() only for backward-compatibility where
necessary, with the intent of eventually ridding the integer interfaces
entirely.

It may be an eternal project, but hey, we are atleast two of us
pursuing it.

Yours,
Linus Walleij
