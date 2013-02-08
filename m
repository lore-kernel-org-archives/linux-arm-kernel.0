From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Feb 2013 22:56:48 +0100
Subject: [PATCH 2/2] ARM: ep93xx: bump IRQ offset to 64
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020809EF8DDB@AUSP01VMBX24.collaborationhost.net>
References: <1360168544-20376-1-git-send-email-linus.walleij@linaro.org>
 <51149648.80402@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0020809EF8DDB@AUSP01VMBX24.collaborationhost.net>
Message-ID: <CACRpkdb-vy8noy+8f5EmvG2qiSajCg-FqaJim3LK7-3tBm5S1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 8, 2013 at 6:38 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:

> I would rather not have this applied.
>
> If you look at the EP93XX_VIC1_VALID_IRQ_MASK you will see that IRQ 0
> (and 1) is not valid. So on EP93xx IRQ 0 is a NO_IRQ.

That the hardware IRQ 0 happens to be unused has nothing to do with
whether or not Linux IRQ 0 is valid.

I rather think it's rather good to bump them up a bit, so that
the reader understands that these are two different number
spaces.

> With VIC1 having a base IRQ of 0 and VIC2 having a base IRQ of 32, the Linux
> irq numbers match the numbers in the EP93xx datasheet. It makes debugging
> a bit easier without having to deal with the offsets.

This is not the design path chosen by Linux, for good or for bad.

If you check /proc/interrupts, you should look for the name of
the user, not the number.

This is why the case where you nail down number offsets
in the VICs irqdomain is called a "legacy domain". And we
don't necessarily want to keep legacy around.

Grant even wanted to get rid of them altogether and only use
descriptors without numbers for IRQs IIRC.

I put the ARM maintainers on the To: line so they can beat me
up if I'm talking rubbish now...

Yours,
Linus Walleij
