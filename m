From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 2 Oct 2010 19:50:19 +0200
Subject: [PATCH] support for SDMA memory to memory transfers
In-Reply-To: <C7E2EBC63FB38847ADEAA1E2CEB3C6D070DC40@HBMNTX3.hbm.com>
References: <C7E2EBC63FB38847ADEAA1E2CEB3C6D070DC40@HBMNTX3.hbm.com>
Message-ID: <AANLkTikO5rUW+KetcKRcXFoTJxy7X1bwekc2MtmPo1YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/1 Wirtl, Tobias <Tobias.Wirtl@hbm.com>:

> This patch adds support for SDMA memory to memory transfers. It
> implements the prep_dma_memcpy function for the dmaengine. I'm sorry for
> the format.
>
> Any comments on this?

If you want comments on DMA engine code, send it to Dan Williams and
the LKML, see the MAINTAINERS file.

There is some weird linebreaks in my mail, looks like this is the
culprit:
> X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4657

Please use git send-email with SMTP server and your patches will
probably look a lot nicer.

> *sdma_prep_dma_memcpy(
> ? ? ? ?bd->ext_buffer_addr = dest;
> ? ? ? ?bd->mode.count = len;
> ? ? ? ?bd->mode.command = 0;
> - ? ? ? ?bd->mode.status = BD_DONE | BD_EXTD | BD_CONT | BD_INTR;
> + ? ? ? ?bd->mode.status = BD_DONE | BD_EXTD | BD_INTR | BD_WRAP;
> //BD_DONE | BD_EXTD | BD_CONT | BD_INTR | BD_WRAP;

What is this C99 comment doing here?

Certainly checkpatch does not agree with them so if you had run
it it would have complained. Apart from that the commented-out code
is also impossible to understand...

Yours,
Linus Walleij
