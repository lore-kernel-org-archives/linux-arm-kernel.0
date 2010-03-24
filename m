From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Mar 2010 09:33:05 +0000
Subject: ARM caches variants.
In-Reply-To: <20100323233952.GF20130@shareable.org>
References: <4BA8B672.7030508@xenomai.org>
	<1269348826.13209.10.camel@e102109-lin.cambridge.arm.com>
	<4BA8BF0A.6030907@xenomai.org>
	<1269351756.13209.34.camel@e102109-lin.cambridge.arm.com>
	<4BA8C932.6060701@xenomai.org>
	<1269354835.13209.45.camel@e102109-lin.cambridge.arm.com>
	<4BA8D2BB.9080504@xenomai.org>
	<1269355564.13209.56.camel@e102109-lin.cambridge.arm.com>
	<20100323233952.GF20130@shareable.org>
Message-ID: <1269423185.29073.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-23 at 23:39 +0000, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > > > Even if you have a 1-way associative cache (some processors allow the
> > > > disabling of the other 3 ways if you want to try), the tag stored with
> > > > the cache line is different between different VAs on a VIVT cache.
> > > >
> > > > So with two different VAs mapping the same PA, if a VA0 access allocates
> > > > the cache line and VA1 would find the same cache line via the index
> > > > calculation, it would get a cache miss because the tags for VA0 and VA1
> > > > do not match.
> > >
> > > But if we assume that it evicts the contents of VA0 and allocates the
> > > cache for VA1 when VA1 is accessed, the system would just work.
> >
> > That's correct, for this particular case it should work (though I think
> > fully associative caches are not that common).
> 
> I think you might have meant 1-way caches

Yes, you are right - 1-way  caches (I think they are also called
directly mapped caches, not sure).

-- 
Catalin
