From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 8 Oct 2009 13:26:45 +0200
Subject: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
In-Reply-To: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <63386a3d0910080426j2a48e5d7wd2d2cb633a5f7a15@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This fixes a compile bug introduced in
>
> ? ? ? ?6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
>
> That commit moved arch/arm/include/asm/mach/mmc.h to
> include/linux/amba/mmci.h. ?Just removing the include was enough.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

The include paths in the kernel lead me astray... Weird that this
driver included that file at all though, but I guess the driver was derived
from MMCI at some early staget and it got left in?

Linus Walleij
