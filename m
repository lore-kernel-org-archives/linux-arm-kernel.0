From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2012 10:03:31 +0200
Subject: [PATCH] RFC: serial: pl011: allow very high baudrates
In-Reply-To: <1348250399-5651-1-git-send-email-linus.walleij@stericsson.com>
References: <1348250399-5651-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdb_+RaVP+vX9hutnhDNfZTUcsLnPsTr8_bY_t_yt8Ni-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 7:59 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The ST Microelectronics variant of the PL011 is capable of supporting
> very high non-standard baud rates, even above 4 Mbps. Mostly this
> works, but when we try to use 4050000 baud, the code in
> tty_termios_encode_baud_rate(), which is called from
> uart_get_baud_rate() will do some fuzzy matching and "snap" the
> baudrate to 4000000 baud, which happens to be in the baud_table[].

So I've found the right solution to this problem, Greg ignore
this patch.

Yours,
Linus Walleij
