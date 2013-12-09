From: steve@s.cotton.clara.co.uk (Steve Cotton)
Date: Mon, 9 Dec 2013 14:26:06 +0000
Subject: [PATCH 3/9] ARM: fix ohci-pxa27x build error with OF enabled
In-Reply-To: <1386543229-1542-4-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-4-git-send-email-ynvich@gmail.com>
Message-ID: <20131209142605.GA9345@s.cotton.clara.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 02:53 +0400, Sergei Ianovich wrote:
> --->8---
> $ make
>   CC [M]  drivers/usb/host/ohci-pxa27x.o
> drivers/usb/host/ohci-pxa27x.c: In function ?ohci_pxa_of_init?:
> drivers/usb/host/ohci-pxa27x.c:310:2: error: implicit declaration of function ?dma_coerce_mask_and_coherent? [-Werror=implicit-function-declaration]
> drivers/usb/host/ohci-pxa27x.c:310:2: error: implicit declaration of function ?DMA_BIT_MASK? [-Werror=implicit-function-declaration]
> --->8---
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
>  # Changes to be committed:
> ---
>  drivers/usb/host/ohci-pxa27x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
> index e89ac4d..97983fd 100644
> --- a/drivers/usb/host/ohci-pxa27x.c
> +++ b/drivers/usb/host/ohci-pxa27x.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_data/usb-ohci-pxa27x.h>

Hi Sergei,

There's already a different patch for this
in the linux-next/master and gregkh/usb/usb-linus trees, but
not in the linux-next/stable or gregkh/usb/usb-next trees.

It adds that include 3 lines higher up, to keep the includes in
alphabetical order.

commit 9876388edfa553960815110acae4544359b385b5
Author:     Daniel Mack <zonque@gmail.com>
AuthorDate: Fri Nov 15 14:19:02 2013 +0100
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Wed Dec 4 16:57:46 2013 -0800

Cheers,
Steve
