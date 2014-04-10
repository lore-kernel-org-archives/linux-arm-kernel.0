From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 20:20:46 +0200
Subject: [PATCH] gpio: mxs: Allow for recursive enable_irq_wake() call
In-Reply-To: <20140409142626.GA2317@dragon>
References: <1395628690-7225-1-git-send-email-marex@denx.de>
 <CACRpkda1qnx24YdfnSwu3tJw9NiVKpKjNbibGoG5JeZ+rAFpeQ@mail.gmail.com>
 <20140409142626.GA2317@dragon>
Message-ID: <CACRpkdZEsab4meuNC7P0thw=NhReEgt3hte=F2v7A6ncPZmd6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 4:26 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Mar 27, 2014 at 10:15:27AM +0100, Linus Walleij wrote:
>> I would like someone to look into converting the MXS to use the new
>> gpiolib irqchip helpers merged on my devel branch so we can centralize
>> and get rid of surplus redundant bug fixing everywhere around the drivers.
>>
>> That code does not use generic irqchip, but rather a regular irqchip+domain
>> and explicitly chained interrupt handlers.
>
> No.  The driver uses generic irqchip.  See function mxs_gpio_init_gc().

Hm I see.

Still I think it should be possible to lift some code into gpiolib also
with generic chips. Must be some elegant refactoring lurking
here...

Yours,
Linus Walleij
