From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Oct 2016 13:58:35 +0100
Subject: [PATCH] drivers: psci: Allow PSCI node to be disabled
In-Reply-To: <20161020123907.GF10234@leverpostej>
References: <20161017104653.18783-1-thierry.reding@gmail.com>
 <20161020123907.GF10234@leverpostej>
Message-ID: <20161020125835.GB8731@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 01:39:07PM +0100, Mark Rutland wrote:
> On Mon, Oct 17, 2016 at 12:46:53PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Allow disabling PSCI support (mostly for testing purposes) by setting
> > the status property to "disabled". This makes the node behave in much
> > the same way as proper device nodes.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> This looks sensible to me; FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Lorenzo, do we need to batch this up with other PSCI patches, or should
> this go direct to arm-soc?

I am aiming at getting the PSCI checker merged too so that we can send
both patches (and others that may turn up) in one go to arm-soc, I will
handle it.

Thanks !
Lorenzo

> Thanks,
> Mark.
> 
> > ---
> >  drivers/firmware/psci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index 8263429e21b8..6c60a5087caf 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -630,7 +630,7 @@ int __init psci_dt_init(void)
> >  
> >  	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> >  
> > -	if (!np)
> > +	if (!np || !of_device_is_available(np))
> >  		return -ENODEV;
> >  
> >  	init_fn = (psci_initcall_t)matched_np->data;
> > -- 
> > 2.10.0
> > 
> 
