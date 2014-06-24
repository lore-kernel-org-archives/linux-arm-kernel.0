From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jun 2014 15:30:51 +0100
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <a718d22a3ef3414fb6992bc54a0a893f@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <5537408.I9tiuCA96J@wuerfel> <20140616164517.GY16758@arm.com>
 <8028011.DbLMpGku5b@wuerfel> <20140616182645.GD16758@arm.com>
 <836ade98fe6141f58476bf981ac5a6bf@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140618123104.GI32699@arm.com>
 <d3c51c2360874a8b9deefaaa8beaf0d9@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140620174952.GD30656@arm.com>
 <a718d22a3ef3414fb6992bc54a0a893f@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140624143051.GK9121@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 07:57:03PM +0100, Varun Sethi wrote:
> > > [Sethi Varun-B16395] We should be considering the bus topology i.e.
> > > what if the device is setting behind a bridge? It's possible the
> > > requestor id for the DMA transaction belongs to the bridge. Also, the
> > > iommu group creation should also take in to account the topology.
> > 
> > Yeah, as I mentioned above, this assumes that RequesterID == StreamID.
> > Are you simply alluding to a non-transparent PCI bridge, or do you have
> > something different? For non-transparent bridges, I guess we can re-use
> > the code already in the kernel (VFIO handles this with its groups IIUC)?
> Yes, we can use the API from patch posted by Alex Williamson.
> https://lkml.org/lkml/2014/5/10/129

Thanks for the pointer. Looks like I can register a dummy function (return
0;) as the iterator and I should end up with the RequesterID I want. Then DT
can map that to the StreamID.

Will
