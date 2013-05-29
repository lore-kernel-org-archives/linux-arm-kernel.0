From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 29 May 2013 14:01:32 -0400
Subject: [PATCH v4 1/4] xen: move xen_setup_runstate_info and
 get_runstate_snapshot to drivers/xen/time.c
In-Reply-To: <alpine.DEB.2.02.1305291718430.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305281835080.4799@kaball.uk.xensource.com>
 <1369763672-12919-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130528181515.GB27718@phenom.dumpdata.com>
 <alpine.DEB.2.02.1305291159220.4799@kaball.uk.xensource.com>
 <20130529155544.GG23775@phenom.dumpdata.com>
 <alpine.DEB.2.02.1305291718430.4799@kaball.uk.xensource.com>
Message-ID: <20130529180132.GB10845@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > > +void xen_setup_runstate_info(int cpu)
> > > > > +{
> > > > > +	struct vcpu_register_runstate_memory_area area;
> > > > > +
> > > > > +	area.addr.v = &per_cpu(xen_runstate, cpu);
> > > > > +
> > > > > +	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
> > > > > +			       cpu, &area))
> > > > > +		BUG();
> > > > 
> > > > The original code did:
> > > > 
> > > > -       rc = HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area, cpu,
> > > > -                               &area);
> > > > -       WARN_ON(rc && rc != -ENOSYS);
> > > > -
> > > > Any reason not to do this?
> > > 
> > > The original x86 code just BUGs out: I took that version over the ia64
> > > version.
> > 
> > Ah, I see it now. OK, then this looks good to me.
> > 
> 
> Can I add your acked-by? ;-)

How about?

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
