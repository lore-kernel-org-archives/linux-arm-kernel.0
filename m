From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Sep 2016 11:06:28 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160831084938.GQ1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home> <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home> <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home> <20160831084938.GQ1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdZBNH=4qZEfcLzqZAN=tum2f3YeoQj0D5PsH+P0Cf+7LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 10:49 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
>
> It would be great to have this tested on Lubbock, and get the PCMCIA
> issues fixed.  Maybe we can look at converting mainstone as well?

I couldn't resist testing on the Compaq iPAQ h3600. It works the
same as before so:
Tested-by: Linus Walleij <linus.walleij@linaro.org> [for Compaq iPAQ H3600]

The only news in the bootlog is this:
sa11x0-pcmcia: probe of sa11x0-pcmcia failed with error -2

This device does have a PCMCIA "sleeve" where I slotted in an
ethernet card at one time to see if I could network this thing.
But I never got the PCMCIA working. Now it seems like I could
actually start looking into that as the driver gives its first sign
of life.

I don't think PCMCIA ever worked on this thing upstream,
but I have a copy of the old linux-handheld kernel tree where
it supposedly was working at one point.

Yours,
Linus Walleij
