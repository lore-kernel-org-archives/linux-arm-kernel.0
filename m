From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 9 May 2013 09:12:01 +0100
Subject: [Xen-devel] [PATCH v3 4/4] xen/arm: account for stolen ticks
In-Reply-To: <alpine.DEB.2.02.1305081712390.18865@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305081446580.18865@kaball.uk.xensource.com>
 <1368027714-14506-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <518A7836.4030705@arm.com>
 <alpine.DEB.2.02.1305081712390.18865@kaball.uk.xensource.com>
Message-ID: <1368087121.17285.86.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-05-08 at 18:03 +0100, Stefano Stabellini wrote:
> > What if we have Xen support enabled but don't run as a Xen guest?
> 
> That's fine as long as the Xen runstate_memory_area interface is
> available.
> Usually I am a great fun of feature flags, so that every feature can be
> dynamically enabled or disabled and an hypervisor interface can be only
> partially implemented.
> 
> However the runstate_memory_area is very old and I would consider it
> one of the core interfaces that need to be available in order to claim
> "Xen compatibility".

I think Marc meant "what if CONFIG_XEN=y but we are running on KVM?". In
that case we wont have set either of the paravirt_steal*_enabled static
keys and so the hook won't be called.

> > > +	static_key_slow_inc(&paravirt_steal_enabled);
> > > +	static_key_slow_inc(&paravirt_steal_rq_enabled);
> > > +


Ian.
