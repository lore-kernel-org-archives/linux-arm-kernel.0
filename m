From: eric@anholt.net (Eric Anholt)
Date: Mon, 12 Dec 2016 09:46:55 -0800
Subject: [PATCH] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when
 appropriate
In-Reply-To: <1481536123-9279-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1481536123-9279-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <87oa0h3ur4.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> A bootloader may start the watchdog device before handing control to
> the kernel - in that case, we should tell the kernel about it so the
> watchdog framework can keep it alive until userspace opens
> /dev/watchdog0.

I don't believe our current bootloaders (the closed firmware or u-boot)
set up the watchdog, but this seems reasonable since they might want to
later.

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161212/673b1918/attachment.sig>
