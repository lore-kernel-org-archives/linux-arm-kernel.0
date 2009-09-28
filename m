From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 28 Sep 2009 20:45:38 +0200
Subject: [PATCH] Move MMCI header to amba include dir
In-Reply-To: <9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
References: <1253625972-19407-1-git-send-email-linus.walleij@stericsson.com>
	<9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <63386a3d0909281145t509f9105x396f5d32b79e9c47@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/28 Scott Branden <sbranden@broadcom.com>:

> You changes cause the bcmring platform to fail to compile.

The noes! Patch mailed.

> Can you go through all the ARM platforms and make the
> necessary adjustments with the change in header files
> for mmc?

I think bcmring was the only one, I missed it because this
patch was boiling when bcmring got merged... Look:

linux-next-work/arch/arm$ grep -r 'asm/mmc.h' . | wc -l
0

Whereas:
linux-next-work/arch/arm$ grep -r 'linux/amba/mmci.h' . | wc -l
10

So I think I've fixed them now.

Linus Walleij
