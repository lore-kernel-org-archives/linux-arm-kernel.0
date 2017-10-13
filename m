From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Oct 2017 17:42:35 +0100
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
In-Reply-To: <20171013155120.GA137489@google.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
Message-ID: <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 08:51:21AM -0700, Brian Norris wrote:

> Yes, this does seem odd to me too. This looks like an arms race hack
> that should be avoided unless we know a legit root cause. Also,
> "probe order implies suspend order" doesn't quite work for async suspend
> anyway, so we'd probably want to express the dependency properly
> anyway.

Yeah, it's the same stuff as we get with initcall ordering.  This sort
of thing does happen with things like PMICs which tend to have hardware
that the system wants to manipulate in the IRQs off part of suspend.
Ideally the dependency annotation stuff would figure things out though
I'm not sure what the status of that is.

> Any chance this is related? Seems like that might break the parent/child
> relationship for master/slave:

> commit d7e2ee257038baeb03baef602500368a51ee9eef
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Mon Apr 11 13:51:03 2016 +0200

>     spi: let SPI masters ignore their children for PM

That's for runtime PM, I'd not expect it to affect system suspend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171013/5cd83500/attachment.sig>
