From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:14:15 +0800
Subject: [RFC 23/34] dmaengine: PL08x: re-jig the starting of txds
In-Reply-To: <E1SZIxA-00070E-Dc@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIxA-00070E-Dc@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdb15mx2jPZ3zqD01htvvLsQ27snsQQ+o=aSM8F6y=WKcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:43 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Rather than code the de-queue of the txd several times, move that into
> the start_txd function. ?Rename this to better illustrate what it's
> now doing, and call this function when starting a delayed memcpy().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?* Eww. ?We know this isn't going to deadlock
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?* but lockdep probably doens't.

Speling...

> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spin_lock(&waiting->lock);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pl08x_start_next_txd(waiting);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spin_unlock(&waiting->lock);

I've seen this construct in the past and have no better suggestions...

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
