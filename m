From: eric@anholt.net (Eric Anholt)
Date: Thu, 08 Feb 2018 08:22:54 +0000
Subject: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
In-Reply-To: <20180207160002.GA9292@embeddedgus>
References: <20180207160002.GA9292@embeddedgus>
Message-ID: <87inb7c2ld.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> Add suffix ULL to constant 9 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> unsigned long long (64 bits, unsigned).
>
> The expression tfr->len * 9 * 1000000 is currently being evaluated
> using 32-bit arithmetic.
>
> Addresses-Coverity-ID: 1339619
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

The effect looks like it would be that we would have chosen polling mode
instead of waiting for interrupts for some transfers >477 seconds.
Seems like a good fix for an unlikely bug.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/e27ae2aa/attachment.sig>
