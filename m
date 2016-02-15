From: eric@anholt.net (Eric Anholt)
Date: Mon, 15 Feb 2016 11:25:18 -0800
Subject: [PATCH v2 0/2] spi: bcm2835aux: auxiliary spi improvements
In-Reply-To: <1455444269-4797-1-git-send-email-stephanolbrich@gmx.de>
References: <1455444269-4797-1-git-send-email-stephanolbrich@gmx.de>
Message-ID: <87povx6ajl.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephan Olbrich <stephanolbrich@gmx.de> writes:

> From: Stephan Olbrich <stephanolbrich@gmx.de>
>
> This patch series has some improvements and fixes for the auxiliary spi.
>
> since v1:
> - the first two patches "fix bitmask defines" and "disable tx fifo empty irq"
>   were picked up by Mark Brown and applied to his spi tree so I don't post
>   them again.
> - speed bits are now reset before setting the new speed in case the speed
>   changes between transfers
> - remove CPHA from master->mode_bits
> - rename CPHA bit mask to RISING to make it more clear why things are done
>   that way
>
> 1. set up spi-mode before asserting cs-gpio
>  As Martin Sperl suggested this is done in the same way as in spi-bcm2835.c
>  acace73df2c1913a526c1b41e4741a4a6704c863
>
> 2. fix CPOL/CPHA setting
>  From what I've seen in the documentation [1] and seen on the scope this chip
>  doesn't support modes with CPHA=1. With this patch spi mode 0 and 2 should
>  work correctly whereas mode 1 and 3 are not supported. 

These are both:

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160215/4831e8e9/attachment.sig>
