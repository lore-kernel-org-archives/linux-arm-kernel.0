From: fthain@telegraphics.com.au (Finn Thain)
Date: Tue, 15 Mar 2016 14:19:58 +1100 (AEDT)
Subject: [PATCH 09/22] ncr5380: Adopt uniform DMA setup convention
In-Reply-To: <56E669F6.8070407@suse.de>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042702.976019738@telegraphics.com.au> <56E669F6.8070407@suse.de>
Message-ID: <alpine.LNX.2.00.1603151313510.9662@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 14 Mar 2016, Hannes Reinecke wrote:

> > @@ -1555,8 +1555,7 @@ static int NCR5380_transfer_dma(struct S
> >  	NCR5380_read(RESET_PARITY_INTERRUPT_REG);
> >  	*data = d + c;
> >  	*count = 0;
> > -	*phase = NCR5380_read(STATUS_REG) & PHASE_MASK;
> > -	return foo;
> > +	return result;
> >  }
> >  
> >  /*
> 
> Don't you miss a phase update here?

I guess I missed explaining the change in the commit log.

The *phase assignment is redundant because after NCR5380_transfer_dma() 
returns control to NCR5380_information_transfer(), the latter routine then 
also returns, and so *phase is dead.

-- 

> 
> Cheers,
> 
> Hannes
> 
