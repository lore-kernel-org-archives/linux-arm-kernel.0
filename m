From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 31 Oct 2017 00:46:53 +0100 (CET)
Subject: [PATCH] tty: amba-pl011: Report AUTOCTS capability to framework
In-Reply-To: <20171030233228.GA3183@wunner.de>
References: <1509368586-26662-1-git-send-email-stefan.wahren@i2se.com>
 <20171030233228.GA3183@wunner.de>
Message-ID: <2129655909.63812.1509407213334@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukas,

> Lukas Wunner <lukas@wunner.de> hat am 31. Oktober 2017 um 00:32 geschrieben:
> 
> 
> On Mon, Oct 30, 2017 at 11:24:31PM +0000, Stefan Wahren wrote:
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2029,9 +2029,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
> >  
> >  		old_cr |= UART011_CR_CTSEN;
> >  		uap->autorts = true;
> > +		port->status |= UPSTAT_AUTOCTS;
> >  	} else {
> >  		old_cr &= ~(UART011_CR_CTSEN | UART011_CR_RTSEN);
> >  		uap->autorts = false;
> > +		port->status &= ~UPSTAT_AUTOCTS;
> >  	}
> >  
> >  	if (uap->vendor->oversampling) {
> 
> Don't you also need to clear the UPSTAT_AUTOCTS bit in pl011_disable_uart()?
> 
> FWIW I posted a patch to linux-serial on Oct 25 which subsumes the above
> patch, would that work for you?
> 
> https://marc.info/?l=linux-serial&m=150891880104614&w=4

sorry for missing your patch. Mine should be ignored.

> 
> Thanks,
> 
> Lukas
