From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 11 Oct 2010 11:13:18 +0200
Subject: [PATCHv2] mmci: work with only one irq
In-Reply-To: <1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
	<1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <AANLkTim5n-SMBbghtHtEfU_5fA8QAoK3uiXJfjtwiJ39@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/11 Rabin Vincent <rabin.vincent@stericsson.com>:

> The DBx500 variants have only one IRQ line hooked up. ?Allow these (and
> any other implementations which choose to use only one irq) to work by
> directing the PIO interrupts also to the first IRQ line.
> (...)
> + ? ? ? ? ? ? ? /* MCI_DATABLOCKEND not used with single irq */
> + ? ? ? ? ? ? ? if (host->singleirq && !data->error)
> + ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = data->blksz * data->blocks;
> +

I replaced that last line with:
host->data_xfered += data->blksz * data->blocks;

In my follow-on "support out-of-order IRQ events" patch, does it make sense?

Once this is in the patch system I'll rebase that patch too...

Yours,
Linus Walleij
