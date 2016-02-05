From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Fri, 5 Feb 2016 15:33:55 +0000
Subject: [QUESTION ]ARM64 external L3 cache support in topology info
In-Reply-To: <56B4B1FA.5030309@arm.com>
References: <5FC3163CFD30C246ABAA99954A238FA8172E13A4@lhreml504-mbs>
 <56B4B1FA.5030309@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8172E1638@lhreml504-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Friday, February 05, 2016 2:30 PM
> To: Shameerali Kolothum Thodi; linux-arm-kernel at lists.infradead.org
> Cc: Sudeep Holla
> Subject: Re: [QUESTION ]ARM64 external L3 cache support in topology
> info
> 
> [..]
> 
> >
> > In our case, the L3 cache seems to be intelligent enough and doesn't
> > require any additional maintenance ops. So there is no cache-
> controller
> > code for this. I am just wondering what's the best way to add this L3
> > cache info to the topology. Overriding the CLIDR register, if there
> is
> > a next-level-cache entry in the dts and then retrieve the cache
> geometry
> > either from dts or from cache specific registers( but this will be
> > implementation specific) ? Or am I missing something here?
> >
> 
> Recent discussion on this [1] made it clear that we need to support
> overriding cache properties using DT for some designs. I will consider
> this "transparent" external/system level cache when I look into moving
> PPC DT code in generic cacheinfo. I am not sure if it's OK to support
> mixed information source for a platform(all internal caches via CLIDR
> and external ones via DT), but we can pick up discussion once we I have
> the patch.

Ok. Will wait for that then. Thanks.

> --
> Regards,
> Sudeep
> 
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-
> October/381758.html
