From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 20:35:44 -0800
Subject: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
In-Reply-To: <1386217896.7152.8.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
 <20131202090253.GE3942@xps8300>
 <1385976238.12531.8.camel@host5.omatika.ru>
 <20131202094932.GF3942@xps8300>
 <1385980005.12531.21.camel@host5.omatika.ru>
 <20131202141033.GK3942@xps8300> <20131205041251.GA24906@kroah.com>
 <1386217896.7152.8.camel@host5.omatika.ru>
Message-ID: <20131205043544.GA28580@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 08:31:36AM +0400, Sergei Ianovich wrote:
> On Wed, 2013-12-04 at 20:12 -0800, Greg Kroah-Hartman wrote:
> > On Mon, Dec 02, 2013 at 04:10:33PM +0200, Heikki Krogerus wrote:
> > > On Mon, Dec 02, 2013 at 02:26:45PM +0400, Sergei Ianovich wrote:
> > > > Who makes the decision which way to go?
> > > 
> > > Greg and Russel make this decision. By having the pxa driver simply
> > > register 8250 ports would probable reduce the code. Thats about the
> > > biggest benefit from it.
> > > 
> > > It would still be something nice to have IMO. Ideally all the
> > > 8250/16x50 UARTs should register the ports with 8250_core.c, and not
> > > create complete uart driver on their own.
> > 
> > I agree, this is the best way to resolve this, having a separate uart
> > driver isn't that good at all to be doing, if at all possible.
> 
> I'm reading the last message as a confirmation that
> drivers/tty/serial/pxa.c needs to be rewritten using 8250_core.c.

Yes, how much work is this really?

thanks,

greg k-h
