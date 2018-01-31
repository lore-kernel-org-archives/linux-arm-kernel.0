From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Jan 2018 13:28:43 +0100
Subject: [RFC PATCH] tty: pl011: Avoid stuck-off spurious interrupts
In-Reply-To: <1517242181-20652-1-git-send-email-Dave.Martin@arm.com>
References: <1517242181-20652-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CACRpkdb8=vNmwOYYTAuDM21CtoCw1868js8wnHTTofK-pZYKGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 5:09 PM, Dave Martin <Dave.Martin@arm.com> wrote:

> Commit 9b96fbacda34 ("serial: PL011: clear pending interrupts")
> clears the RX and receive timeout interrupts on pl011 startup, to
> avoid a screaming-interrupt scenario that can occur when the
> firmware or bootloader leaves these interrupts spuriously
> asserted.

It looks OK to me.

I could never reproduce this issue myself, it was just reported by
Chanho, and we came up with this fix. AFAICR it was working fine
on ARM reference designs and my ST-Ericsson platforms before
and after.

I do not remember what hardware Chanho was seeing this problem
on, but let's loop in Chanho and ask.

Yours,
Linus Walleij
