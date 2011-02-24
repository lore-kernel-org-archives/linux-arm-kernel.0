From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Thu, 24 Feb 2011 19:25:51 +0530
Subject: [PATCH v3 1/2] PRUSS UIO driver support
In-Reply-To: <alpine.LFD.2.00.1102232153500.2701@localhost6.localdomain6>
References: <1298469161-7644-1-git-send-email-pratheesh@ti.com>
	<1298469161-7644-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1102232057260.2701@localhost6.localdomain6>
	<4D6572ED.9020805@mvista.com>
	<alpine.LFD.2.00.1102232153500.2701@localhost6.localdomain6>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE49815@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Thursday, February 24, 2011 2:24 AM
> To: Sergei Shtylyov
> Cc: TK, Pratheesh Gangadhar; davinci-linux-open-
> source at linux.davincidsp.com; Chatterjee, Amit; gregkh at suse.de; linux-
> kernel at vger.kernel.org; hjk at hansjkoch.de; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] PRUSS UIO driver support
> 
> On Wed, 23 Feb 2011, Sergei Shtylyov wrote:
> > Hello.
> >
> > On 23-02-2011 23:25, Thomas Gleixner wrote:
> >
> > > > +	prussio_virt_addr =
> > > > +	    ioremap(regs_prussio->start,
> > > > +		    regs_prussio->end - regs_prussio->start + 1);
> >
> > > Either make those variable names shorter or do:
> >
> > >         len = regs_prussio->end - regs_prussio->start + 1;
> >
> >    Or even:
> >
> > 	len = resource_size(regs_prussio);
> >
> > >         prussio_virt_addr = ioremap(regs_prussio->start, len);
> 
> Good point. Forgot about that one :)
> 
Thanks will do this.

Pratheesh
