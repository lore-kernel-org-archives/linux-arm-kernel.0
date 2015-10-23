From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 12:04:48 +0200
Subject: [PATCH] serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()
In-Reply-To: <1444249636-25661-1-git-send-email-timur@codeaurora.org>
References: <1444249636-25661-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdZNv-Q3-0KntE4k1dLWHn30H5POpmEaOWKiWCsuPMtjFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2015 at 10:27 PM, Timur Tabi <timur@codeaurora.org> wrote:

> The UART_DUMMY_DR_RX status bit is equal to (1 << 16), so a u16 is too small
> to hold that value.  The result is that UART_DUMMY_DR_RX is never passed
> to uart_insert_char().  This means that we're always accepting characters,
> even when CREAD (in termios) is not set.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
