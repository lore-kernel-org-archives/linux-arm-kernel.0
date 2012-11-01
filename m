From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 1 Nov 2012 23:29:22 +0100
Subject: [PATCH] i2c: at91: add a sanity check on i2c message length
In-Reply-To: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20121101222922.GD22956@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 04:25:58PM +0200, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> If the i2c message length is zero, i2c-at91 will directly return an error
> instead of trying to send a zero-length message.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

What happens if you send a 0 byte message? Some hardware is able to do
this and it will be used in SMBUS QUICK which the driver states to
support according to at91_twi_func().

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121101/f5d6d91d/attachment.sig>
