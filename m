From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Aug 2014 16:33:42 +0100
Subject: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <6a3d4048ddb84bd19c847adf7f02fc52@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
 <87a9774lf5.fsf@nvidia.com> <20140815115110.GO27466@arm.com>
 <6a3d4048ddb84bd19c847adf7f02fc52@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140822153342.GD17255@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Varun,

On Tue, Aug 19, 2014 at 01:11:43PM +0100, Varun Sethi wrote:
> > I think there's some confusion here. The ARM architected SMMU does not
> > perform any StreamID translation -- it sees an incoming ID and uses that to
> > lookup a set of translation tables. 
> 
> I don't completely agree with this. In case of MMU-500  don't we have the
> "TBUID + device assigned stream ID" representing the stream ID for
> matching at the TCU? In case of our platform, we have hot pluggable device
> objects comprising of devices connected to different TBUs. We have a
> requirement to use a single stream ID for all the distributed objects. We
> will have to use the stream ID masking capability to mask out the TBU ID.

Please try to avoid mixing up micro-architectural details (i.e. how the
MMU-500 is integrated) with the software view defined by the architecture.

The point was that we don't need to over-engineer Linux to perform things
like StreamID (re)assignment, because that isn't the way the architecture is
designed. Your hotplug architecture may require the notion of masks, but
we can treat that as a fixed property of the hardware as opposed to something
we have to manage in the OS.

Will
