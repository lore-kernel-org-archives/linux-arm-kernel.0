From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 Aug 2014 10:16:37 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the dma
 controller API
In-Reply-To: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAMuHMdXEH9koVnSS3EWjyUiiSOOOU3EdcT9JHAWNpfmVWQ2opQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Wed, Jul 30, 2014 at 6:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The dmaengine is neither trivial nor properly documented at the moment, which
> means a lot of trial and error development, which is not that good for such a
> central piece of the system.
>
> Attempt at making such a documentation.

Great, thanks!

> +Our dma_device structure has a field called caps_mask that holds the
> +various type of transaction supported, and you need to modify this

types of transactions

> +mask using the dma_cap_set function, with various flags depending on
> +transaction types you support as an argument.

> +  * DMA_SLAVE
> +    - The device can handle device to memory transfers, including
> +      scatter-gather transfers.
> +    - While in the mem2mem case we were having two distinct type to

types

> +      deal with a single chunk to copy or a collection of them, here,
> +      we just have a single transaction type that is supposed to
> +      handle both.

> +  * DMA_INTERLEAVE
> +    - The device support interleaved transfer. Those transfers usually

supports

> +      involve an interleaved set of data, with chunks a few bytes
> +      wide, where a scatter-gather transfer would be quite
> +      inefficient.

> +The functions that we have to fill in there, and hence have to
> +implement, obviously depend on the transaction type you reported as

types

> +supported.

> +   * device_issue_pending
> +     - Takes the first descriptor in the pending queue, and start the

starts

> +       transfer. Whenever that transfer is done, it should move to the
> +       next transaction in the list.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
