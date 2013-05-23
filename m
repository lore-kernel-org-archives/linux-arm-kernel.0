From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 May 2013 09:56:46 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
Message-ID: <CACRpkdaWADjy1YZXTcRaXU+ZsS6_pG0hojQdnz=qeTgyVY7_Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 3:35 PM, Oliver Schinagl
<oliver+list@schinagl.nl> wrote:

(...)
> While initially these fuses are used to somewhat determin the chipID, these
> appear to be writeable by the user and thus can be used for other purpouses.
> For example storing a 128 bit root key, a unique serial number, which could
> then even be used as a MAC address.
(...)
Then follows some code to read out the keys from sysfs I guess..
> +static int __init sid_probe(struct platform_device *pdev)

It's really simple to actually make the kernel use this to seed the
entropy pool.

#include <linux/random.h>
add_device_randomness(u8 *, num);

If you know after probe that you can read out a number of bytes
of device-unique data, I think you should add those bytes to the
entropy pool like this.

Yours,
Linus Walleij
