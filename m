From: eric@anholt.net (Eric Anholt)
Date: Thu, 28 Jan 2016 14:34:14 -0800
Subject: [PATCH V3 3/4] serial: bcm2835: add driver for bcm2835-aux-uart
In-Reply-To: <1453032932-2512-4-git-send-email-kernel@martin.sperl.org>
References: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
 <1453032932-2512-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <87h9hxfi55.fsf@eliezer.anholt.net>
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
> This driver handles this device correctly and handles the difference in
> the HW divider by scaling up the clock by a factor of 2.
>
> The approach to write a separate (wrapper) driver instead of using a
> multiplying clock and "ns16550" as compatibility in the device-tree
> has been recommended by Stephen Warren.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/7a9e510a/attachment.sig>
