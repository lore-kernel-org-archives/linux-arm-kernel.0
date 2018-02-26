From: eric@anholt.net (Eric Anholt)
Date: Mon, 26 Feb 2018 15:33:50 -0800
Subject: [PATCH] i2c: bcm2835: Avoid clock stretching timeouts
In-Reply-To: <1519422151-6218-1-git-send-email-stefan.wahren@i2se.com>
References: <1519422151-6218-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87fu5njpgh.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> From: Eric Anholt <eric@anholt.net>
>
> The CLKT register contains at poweron 0x40, which at our typical 100kHz
> bus rate means .64ms. But there is no specified limit to how long devices
> should be able to stretch the clocks, so just disable the timeout. We
> still have a timeout wrapping the entire transfer.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
> Hi,
> just like "i2c: bcm2835: Set up the rising/falling edge delays" this is a
> outstanding bugfix. Unfortunately i only have I2C slaves, which doesn't
> stretch the clock. So test feedback is very welcome.

I also didn't have any particular devices that this fixed.  It was just
an issue that came up in a previous discussion of clock stretching.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/0b6ffd48/attachment.sig>
