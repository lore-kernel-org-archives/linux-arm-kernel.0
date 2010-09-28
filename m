From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 28 Sep 2010 11:13:02 +0200
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <201005152214.53993.sshtylyov@ru.mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
Message-ID: <AANLkTinuQsSP1EHWn5DS_9PMrsgj+fpjLOOkpnnBaf8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/15 Sergei Shtylyov <sshtylyov@ru.mvista.com>:

> Add support for Texas Instuments Communication Port Programming Interface 4.1
> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.

Sorry for late feedback ...

> +++ linux-davinci/arch/arm/common/cppi41.c

Can you migrate this driver to drivers/dma/cppi41.c and use the
DMAengine interface like so many DMA drivers we have created
recently, or is there some very special characteristics about this
DMA controller meriting it to be placed in arch/arm/*?

Note: we have the support for PL08x found in ARM reference
designs queued for drivers/dma/amba-pl08x.c,
not arch/arm/common/*.

The rationale about this is to lower the churn in arch/arm/*
and put drivers into the proper subsystems, and in this case
there is an appropriate subsystem to be used.

Yours,
Linus Walleij
