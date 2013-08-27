From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 26 Aug 2013 20:50:43 -0700
Subject: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3
 operations
In-Reply-To: <1375825238-18299-1-git-send-email-s-anna@ti.com> (Suman Anna's
 message of "Tue, 6 Aug 2013 16:40:38 -0500")
References: <1375825238-18299-1-git-send-email-s-anna@ti.com>
Message-ID: <87li3n6bcc.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suman Anna <s-anna@ti.com> writes:

> The WkupM3 mailbox used for triggering PM operations such as suspend
> and resume on AM33x/AM43x is special in that the M3 processor cannot
> access the mailbox registers. However, an interrupt is needed to be
> sent to request the M3 to perform a desired PM operation. This patch
> adds the support for this special mailbox through separate ops for
> this mailbox. These ops are designed to have the WkupM3's Rx interrupt
> programmed within the driver, during transmission of a message. The
> message is immediately read back and the internal mailbox interrupt
> acknowledged as well to avoid triggering any spurious interrupts to
> the M3.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Dumb Q: why does all this extra logic belong in the mailbox driver and
not in the wkup_m3 driver?  To me, this seems like part of the IPC
protocol between the MPU and M3 firmware, and not an inherent part of
the AM33xx mbox.

Kevin
