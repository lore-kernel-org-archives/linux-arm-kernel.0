From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 27 Jun 2011 16:24:01 -0600
Subject: [RFC 1/8] drivers: add generic remoteproc framework
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA202EE00@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-2-git-send-email-ohad@wizery.com>
	<20110627204958.GB20865@ponder.secretlab.ca>
	<FFF198FBBF957F4393BA834040FEFFA202EE00@DFLE35.ent.ti.com>
Message-ID: <20110627222401.GE20865@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 09:52:30PM +0000, Grosen, Mark wrote:
> > From: Grant Likely
> > Sent: Monday, June 27, 2011 1:50 PM
> 
> Grant, thanks for the feedback. I'll try to answer one of your
> questions below and leave the rest for Ohad.
> 
> Mark
>  
> > > +Every remoteproc implementation must provide these handlers:
> > > +
> > > +struct rproc_ops {
> > > +	int (*start)(struct rproc *rproc, u64 bootaddr);
> > > +	int (*stop)(struct rproc *rproc);
> > > +};
> > > +
> > > +The ->start() handler takes a rproc handle and an optional bootaddr
> > argument,
> > > +and should power on the device and boot it (using the bootaddr
> > argument
> > > +if the hardware requires one).
> > 
> > Naive question: Why is bootaddr an argument?  Wouldn't rproc drivers
> > keep track of the boot address in their driver private data?
>  
> Our AMPs (remote processors) have a variety of boot mechanisms that vary
> across the different SoCs (yes, TI likes HW diversity). In some cases, the
> boot address is more like an entry point and that comes from the firmware,
> so it is not a static attribute of a driver. Correct me if I misunderstood
> your question.

More to the point, I would expect the boot_address to be a property of
the rproc instance because it represents the configuration of the
remote processor.  It seems odd that the caller of ->start would know
better than the rproc driver about the entry point of the processor.

g.
