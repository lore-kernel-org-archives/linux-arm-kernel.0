From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 02 Dec 2013 13:23:58 +0400
Subject: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
In-Reply-To: <20131202090253.GE3942@xps8300>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
 <20131202090253.GE3942@xps8300>
Message-ID: <1385976238.12531.8.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-02 at 11:02 +0200, Heikki Krogerus wrote:
> On Sun, Dec 01, 2013 at 10:26:14AM +0400, Sergei Ianovich wrote:
> > PXA serial ports have "standard" UART names (ttyS[0-3]), major
> > device number (4) and first minor device number (64) by default.
> > 
> > If the system has extra 8250 serial port hardware in addition
> > to onboard PXA serial ports, default settings produce a device
> > allocation conflict.
> > 
> > The patch provides a configuration option which can move onboard
> > ports out of the way of 8250_core by assigning a different (204)
> > major number and corresponding device names (ttySA[0-3]).
> > 
> <snip>
> 
> If drivers/tty/serial/pxa.c was converted to an other probe driver for
> the 8250, this would not be an issue.

It seems that my patch is not going to be accepted. However, there is a
device which has both PXA ports and a additional 8250 accent chip. As a
result, there is a device allocation conflict. For the device to be
usable the conflict needs to be resolved.

Do you mean that drivers/tty/serial/pxa.c needs to be rewritten to
support lp8x4x special case?
