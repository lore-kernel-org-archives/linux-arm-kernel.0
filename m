From: eric@anholt.net (Eric Anholt)
Date: Mon, 14 Sep 2015 10:53:16 -0400
Subject: [PATCH 0/4] bcm2835: enable auxiliary uart1
In-Reply-To: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87r3m1jbmr.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The bcm2835 SOC contains an auxiliary uart, which is very close
> to the ns16550 with some differences.
>
> The big difference is that the uart HW is not using an internal divider
> of 16 but 8, which results in an effictive baud-rate being twice
> the requested baud-rate.
>
> The bcm2835-aux-uart is also special in such that it is enabled/disabled
> by a gate in the clock, which is managed by the clk-bcm2835-aux
> clock driver.
>
> there are 2 options:
> * defining the clock-frequency property in the device tree to 500k
>   instead of 250k, but this keeps the HW block disabled making the
>   uart not work.
> * defining a clock in the device tree, but this results in a baud rate
>   that is twice the requested baud-rate.
>
> To address this this patch-set introduce a new property in the device tree
> to define a clock divider other than 16.
>
> This currently just scales the clock by a factor of 16/divider.
>
> Note that the use of fixed-factor-clock has also been proposed as a
> workarround, but this does not really describe the hw in the device tree
> so another solution was needed that allows a correct representation of
> the HW in the device tree.

I personally lean toward the fixed-factor-clock solution, but could go
either way.  Serial maintainers, what do you think?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/02685b3e/attachment.sig>
