From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Sep 2016 08:17:50 +0200
Subject: [PATCH] tty/serial: atmel: fix fractional baud rate computation
In-Reply-To: <20160921104414.16241-1-nicolas.ferre@atmel.com>
References: <20160921104414.16241-1-nicolas.ferre@atmel.com>
Message-ID: <20160926061750.4jjgpbttdesdyrae@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 21, 2016 at 12:44:14PM +0200, Nicolas Ferre wrote:
> From: Alexey Starikovskiy <aystarik@gmail.com>
> 
> The problem with previous code was it rounded values in wrong
> place and produced wrong baud rate in some cases.
> 
> Signed-off-by: Alexey Starikovskiy <aystarik@gmail.com>
> [nicolas.ferre at atmel.com: port to newer kernel and add commit log]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I first thought this patch results in not always picking the optimal
divider in some cases. But given the right error function (i.e.
error(r) = abs(1/r_target - 1/r_actual) which minimizes the error in the
time domain and so guarantees the maximal count of matched samples) it
can be proved to result in the right values (assuming no overflow etc.).

As writing formulas in email is cumbersome, see the attachment for a
prove.

Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: baudrate.pdf
Type: application/pdf
Size: 69704 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160926/02579e68/attachment-0001.pdf>
