From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 19 Jan 2011 17:37:39 +0000
Subject: [PATCH 2/2] serial: msm: Add support for UARTDM cores
In-Reply-To: <8yaaaiwsstw.fsf@huya.qualcomm.com>
References: <1295407585-18386-1-git-send-email-stepanm@codeaurora.org>
	<20110119082534.GA9569@gallagher>
	<8yaaaiwsstw.fsf@huya.qualcomm.com>
Message-ID: <20110119173739.GE3341@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 09:31:55AM -0800, David Brown wrote:
> On Wed, Jan 19 2011, Jamie Iles wrote:
> 
> >> @@ -38,9 +40,20 @@ struct msm_port {
> >>  	struct uart_port	uart;
> >>  	char			name[16];
> >>  	struct clk		*clk;
> >> +	struct clk		*pclk;
> >>  	unsigned int		imr;
> >> +	unsigned int            *gsbi_base;
> >> +	int			is_dm;
> >> +	unsigned int		old_snap_state;
> >>  };
> >
> > Out of interest, what does .is_dm mean?  Is that obvious to someone who 
> > knows about msm?
> 
> It would be clear to people rather familiar with the chip, but I agree
> it's probably not that clear of a name.
> 
> We have two UART blocks we use in the MSMs, the older one, supported by
> this driver before this change, and a newer one that was designed to
> work with our DMA engine (known as the Data Mover, or dm).  This newer
> UART can be used in a somewhat compatible manner when being used for
> serial-port type operations.
> 
> I'm not sure what would be a better name for the flag, though.  The
> block is called UARTDM.

Ok, it was mainly out of curiosity.  I guess it could be 'use_dma' or 
perhaps a comment to explain what DM is but my curiosity is now 
satisfied ;-)

Jamie
