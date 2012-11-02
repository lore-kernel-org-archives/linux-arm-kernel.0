From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 2 Nov 2012 12:14:32 +0100
Subject: [PATCH] i2c: at91: add a sanity check on i2c message length
In-Reply-To: <5093A8CD.60006@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de> <5093A8CD.60006@atmel.com>
Message-ID: <20121102111432.GD21313@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 12:04:45PM +0100, ludovic.desroches wrote:
> Hi Wolfram,
> 
> Le 11/01/2012 11:29 PM, Wolfram Sang a ?crit :
> >On Wed, Oct 10, 2012 at 04:25:58PM +0200, ludovic.desroches at atmel.com wrote:
> >>From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>
> >>If the i2c message length is zero, i2c-at91 will directly return an error
> >>instead of trying to send a zero-length message.
> >>
> >>Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> >What happens if you send a 0 byte message? Some hardware is able to do
> >this and it will be used in SMBUS QUICK which the driver states to
> >support according to at91_twi_func().
> 
> Without this I had some data corruption when writing to / reading
> from a serial eeprom (depending on the IP version).
> 
> Yes SMBUS quick command is supported but is not managed in the
> driver, we have to tell explicitly the IP that we want to send this
> command.

Ok, so unless you want to implement the support, please update this
patch with a comment that SMBUS_QUICK is a TODO and remove the
SMBUS_QUICK capability.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/48709ea9/attachment-0001.sig>
