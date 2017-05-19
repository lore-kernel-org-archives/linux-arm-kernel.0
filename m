From: eric@anholt.net (Eric Anholt)
Date: Fri, 19 May 2017 11:09:54 -0700
Subject: [PATCH] serial: 8250: Add CAP_MINI, set for bcm2835aux
In-Reply-To: <8d9c605a-bff7-607c-2c5b-4ec75e68ac2d@raspberrypi.org>
References: <8d9c605a-bff7-607c-2c5b-4ec75e68ac2d@raspberrypi.org>
Message-ID: <87vaowg1l9.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phil Elwell <phil@raspberrypi.org> writes:

> The AUX/mini-UART in the BCM2835 family of procesors is a cut-down
> 8250 clone. In particular it is lacking support for the following
> features: CSTOPB PARENB PARODD CMSPAR CS5 CS6
>
> Add a new capability (UART_CAP_MINI) that exposes the restrictions to
> the user of the termios API by turning off the unsupported features in
> the request.
>
> N.B. It is almost possible to automatically discover the missing
> features by reading back the LCR register, but the CSIZE bits don't
> cooperate (contrary to the documentation, both bits are significant,
> but CS5 and CS6 are mapped to CS7) and the code is much longer.
>
> See: https://github.com/raspberrypi/linux/issues/1561
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/cbe32ac4/attachment.sig>
