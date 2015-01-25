From: marcel@holtmann.org (Marcel Holtmann)
Date: Sun, 25 Jan 2015 12:36:32 -0800
Subject: [PATCH 4/4] tty: Remove external interface for tty_set_termios()
In-Reply-To: <1422215094-3216-5-git-send-email-peter@hurleysoftware.com>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
 <1422215094-3216-5-git-send-email-peter@hurleysoftware.com>
Message-ID: <6C672878-BEFC-4B8D-AC26-1320723ACFCB@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> tty_set_termios() is an internal helper intended for file scope use.
> 
> UART drivers which are capable of driving the RTS pin must
> properly handle the tiocmset() method, regardless of termios settings.
> A failure to do so is a UART driver bug and should be fixed there.
> Do not use this interface to workaround UART driver bugs.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: <linux-bluetooth@vger.kernel.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> drivers/bluetooth/hci_ath.c | 15 ++-------------
> drivers/tty/tty_ioctl.c     |  3 +--
> include/linux/tty.h         |  1 -
> 3 files changed, 3 insertions(+), 16 deletions(-)

I think the less complication is if this goes through the TTY tree.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel
