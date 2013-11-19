From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Nov 2013 17:35:24 +0000
Subject: Report from 2013 ARM kernel summit
In-Reply-To: <20131119.114054.663999769447782808.hdoyu@nvidia.com>
References: <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
 <20131115070627.6CF65C4079B@trevor.secretlab.ca>
 <20131119.114054.663999769447782808.hdoyu@nvidia.com>
Message-ID: <20131119173524.GK11778@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 09:40:54AM +0000, Hiroshi Doyu wrote:
> Grant Likely <grant.likely@secretlab.ca> wrote @ Fri, 15 Nov 2013 08:06:27 +0100:
> > On Mon, 11 Nov 2013 10:47:23 +0100, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> > > 1, When a device is populated, it checks if that device is IOMMU'able
> > >    or not. This is identified by "#stream-id-cells" in DT. If
> > >    a device is normal(non IOMMU), a device is populated. If a device
> > >    is IOMMU'able, it continues to be checked.

[...]

> > > I'm not so sure if this dependecy on "#stream-id-cells" is acceptable
> > > or not, but I haven't any better idea right now.
> > 
> > It seems a little fragile to me too. I'd rather the IOMMU requirement be
> > described more explicitly.
> 
> I think that Will Deacon can do better than I.

I already commented briefly here:

  http://www.spinics.net/lists/devicetree/msg11513.html

basically deferring to DT people :)

Anyway, I'm happy to tighten up the IOMMU requirement description but
*not* at the expense of breaking what we currently have for the ARM SMMU,
which is being used by Calxeda.

Adding Andreas and Rob for input on potential binding additions to the SMMU.

Will
