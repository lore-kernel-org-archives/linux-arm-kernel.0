From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Dec 2009 15:07:10 +1100
Subject: [PATCH] PCI Domains Support
In-Reply-To: <4B35356D.7090604@ms1.techarea.org>
References: <4B28EB0F.3070409@ms1.techarea.org>
	<20091217000620.GC22449@verge.net.au>
	<4B2A2B92.6020809@ms1.techarea.org>
	<20091220012728.GD12578@verge.net.au>
	<4B2F0EF9.101@ms1.techarea.org>
	<20091222045540.GB4411@verge.net.au>
	<4B35356D.7090604@ms1.techarea.org>
Message-ID: <20091223040710.GA3352@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2009 at 05:58:05AM +0800, Richard Liu wrote:
> Simon Horman wrote:
> >> Actually, most ARM platforms didn't need PCI domains.
> >>
> >> So, original patch is
> >>
> >> +config PCI_DOMAINS
> >> +        def_bool y
> >> +        depends on PCI && ARCH_CXXXXXX
> >> +
> >>
> >> But I removed the "&& ARCH_CXXXXXXX" before I provided the patch.
> >> Because ARCH_CXXXXXXX is not exist in ARM Linux kernel now (maybe it
> >> would be committed at someday)
> >>     
> >
> > Ok, now I am completely confused. Nothing currently in-tree should
> > use PCI_DOMAINS, but it defaults to y and nothing switches it to n?
> >
> > Perhaps the following would be more appropriate:
> >
> > config PCI_DOMAINS
> >         bool
> >
> > And then platforms can "select PCI_DOMAINS" as needed.
> >
> >   
> You are right,
> Don't use def_bool is right choice.
> 
> I only maintain one arch, so I didn't think too much.
> 
> Should I regenerate a new patch, or you will handle it ?
> 
> 

I think it would be best if you regenerated your patch.
