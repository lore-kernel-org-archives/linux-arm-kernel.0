From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 23 Feb 2011 21:54:19 +0100 (CET)
Subject: [PATCH v3 1/2] PRUSS UIO driver support
In-Reply-To: <4D6572ED.9020805@mvista.com>
References: <1298469161-7644-1-git-send-email-pratheesh@ti.com>
	<1298469161-7644-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1102232057260.2701@localhost6.localdomain6>
	<4D6572ED.9020805@mvista.com>
Message-ID: <alpine.LFD.2.00.1102232153500.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Feb 2011, Sergei Shtylyov wrote:
> Hello.
> 
> On 23-02-2011 23:25, Thomas Gleixner wrote:
> 
> > > +	prussio_virt_addr =
> > > +	    ioremap(regs_prussio->start,
> > > +		    regs_prussio->end - regs_prussio->start + 1);
> 
> > Either make those variable names shorter or do:
> 
> >         len = regs_prussio->end - regs_prussio->start + 1;
> 
>    Or even:
> 
> 	len = resource_size(regs_prussio);
> 
> >         prussio_virt_addr = ioremap(regs_prussio->start, len);

Good point. Forgot about that one :)

Thanks,

	tglx
