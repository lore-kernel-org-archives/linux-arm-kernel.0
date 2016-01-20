From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 20 Jan 2016 15:02:49 -0300
Subject: [PATCH v3] arm: irq: l2c: do not print error in case of missing
 l2c from dtb
In-Reply-To: <1452593472-10703-1-git-send-email-andi.shyti@samsung.com>
References: <5694BABF.3070200@samsung.com>
 <1452593472-10703-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <CABxcv=nKGvvWiQ4Q+nDbr-oy-gH1NXyyMEL19h9j53pgWBP4dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andi,

On Tue, Jan 12, 2016 at 7:11 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> In some architectures the L2 cache controller is integrated in the
> processor's block itself and it doesn't use any external cache
> controller. This means that an entry in the board's dtb related
> to the l2c is not necessary.
>
> Distinguish between error codes and do not print anything in case
> l2x0_of_init() doesn't find any L2C DTB entry and returns -ENODEV.
>
> This patch mutes the following error message:
>
>    L2C: failed to init: -19
>
> on boards like odroid-xu4, cortex A7/A15, which don't have
> external cache controller.
>

The patch also looks good to me and makes the error message to go away
in my Exynos5800 Peach Pi.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
