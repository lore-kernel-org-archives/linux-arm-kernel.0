From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Aug 2015 11:20:00 +0200
Subject: [PATCH 3/9] gpio: Allow hogged gpios to be requested
In-Reply-To: <20150728091753.GJ28535@localhost>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
 <20150717202702.GK7013@pengutronix.de>
 <20150719140142.GV26287@pengutronix.de>
 <20150728091753.GJ28535@localhost>
Message-ID: <CACRpkdbHwCNttDCEUyYq_5REh1PDuR__XDeLD0mR6NqfO6h_HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 11:17 AM, Johan Hovold <johan@kernel.org> wrote:
> On Sun, Jul 19, 2015 at 04:01:42PM +0200, Markus Pargmann wrote:

>> > I don't like this patch. IMHO hogging is a "use" of a GPIO that should
>> > prevent it being requested.
>>
>> I disagree with you here. The original patch stated in its description
>> that it was designed to initialize GPIOs. In my understanding this does
>> not necessarily mean that a hogged GPIO has to be blocked forever.
>
> IIRC, this use case was discussed but was rejected by Linus when hogs
> were added:
>
>         https://lkml.kernel.org/r/CACRpkdZcNcPBYQM438CZJx1gYst9BFBSTj-3Qv2aPGF9pdWa5g at mail.gmail.com
>
> Linus?

Yeah that is true. But maybe I softened up a bit.

Basically I want to avoid having two very similar mechanisms.

But that is maybe more of a question of how the code is
arranged and named than what it is called. It would be nicer
if this was referring to initial values rather than hogging,
the mechanism inside the kernel could be the same.

But then there is the path where something that is initially
a hog is turned into a userspace GPIO. Then it is essentially
not a hog anymore, so this property is not static.

Yours,
Linus Walleij
