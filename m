From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 12 Jul 2018 17:23:41 +0200
Subject: [PATCH 3/3] tty/serial: atmel: manage shutdown in case of RS485
 or ISO7816 mode
In-Reply-To: <20180712145827.GB22502@kroah.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711132623.13227-1-ludovic.desroches@microchip.com>
 <20180712145827.GB22502@kroah.com>
Message-ID: <20180712152341.p4lmjyldujv6et56@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 04:58:27PM +0200, Greg KH wrote:
> On Wed, Jul 11, 2018 at 03:26:23PM +0200, Ludovic Desroches wrote:
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> > 
> > In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
> > Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
> > calling atmel_stop_tx() by using the atomic information tasklet_shutdown
> > that is already in place for this purpose.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > ---
> >  drivers/tty/serial/atmel_serial.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Did you send this patch twice?
> 
> confused,

Yes sorry, as I didn't receive patch 3/3, I resend it. At the end, it
was sent twice.

Regards

Ludovic

> 
> greg k-h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
