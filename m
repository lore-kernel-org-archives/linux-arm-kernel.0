From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 6 Nov 2009 21:40:46 +0100
Subject: [PATCH] [ARM] serial/pxa: work around Errata #75
In-Reply-To: <1257245235-14783-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257245235-14783-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091106204046.GA8952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[Added Greg to Cc:]

On Tue, Nov 03, 2009 at 11:47:15AM +0100, Uwe Kleine-K?nig wrote:
> Intel(R) PXA27x Processor Family Specification Update (Nov 2005)
> says:
> 
>   E75. UART: Baud rate may not be programmed correctly on
>        back-to-back writes.
> 
>   Problem:
>   When programming the Divisor Latch registers, Low and High (DLL and
>   DLH), with back-to-back writes, the second register write may not
>   take effect. The result is an incorrect baud rate.
> 
>   Workaround:
>   After programming the first Divisor Latch register, read and verify
>   it before programming the second Divisor Latch register.
> 
> This was hit when changing the baud rate from 115200 to 9600 while
> receiving characters at 9600 Bd.
> 
> And fixed indention of some comments nearby.
I havn't received any feed-back for this up to now.

Did I address the right people?  Are you just burried in work?
Assuming the patch is OK, which is the right path into mainline?
Some patches touching drivers/serial/pxa.c went in via Russell's tree,
bdc04e3 (serial: move delta_msr_wait into the tty_port) went in via
gregkh/tty-2.6.

Greg: as you didn't get the original patch you can find it below.

Best regards
Uwe
