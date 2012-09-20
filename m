From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Sep 2012 20:00:34 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120920190034.GB15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 11:46:08AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The ST Microelectronics variant of the PL011 is capable of supporting
> very high non-standard baud rates, even above 4 Mbps. However the
> uart_get_baud_rate() will not allow us to set these, so override that
> calculation on very high speeds.

You don't explain why it doesn't.  It should in theory allow you to,
because there's no limits within that function other than those which
you pass in as the minimum and maximum.

If your userspace hasn't been updated to use the integer baud rate
setting mechanisms, then that could be where the problem lies.
Alternatively, if some Bxxxx setting is not being respected by
tty_termios_baud_rate(), that also would need fixing.

But the fix you propose in this patch just looks wrong.
