From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Nov 2018 11:33:43 +0100
Subject: [PATCH v3 2/6] spi: Deal with slaves that return from
 transfer_one() unfinished
In-Reply-To: <20181113102228.820214-3-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
 <20181113102228.820214-3-lkundrak@v3.sk>
Message-ID: <CAMuHMdU0_CnXGzWNkb4q1dm1yoVOkG=Hhr0BnS3dYdjd-7A-+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
>
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
