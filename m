From: jacob.jun.pan@linux.intel.com (Jacob Pan)
Date: Wed, 5 Sep 2018 11:18:35 -0700
Subject: [PATCH v2 03/40] iommu/sva: Manage process address spaces
In-Reply-To: <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
Message-ID: <20180905111835.7f3ae40e@jacob-builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Sep 2018 14:14:12 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > + *
> > + * On Arm and AMD IOMMUs, entry 0 of the PASID table can be used
> > to hold
> > + * non-PASID translations. In this case PASID 0 is reserved and
> > entry 0 points
> > + * to the io_pgtable base. On Intel IOMMU, the io_pgtable base
> > would be held in
> > + * the device table and PASID 0 would be available to the
> > allocator.
> > + */  
> very nice explanation
With the new Vt-d 3.0 spec., 2nd level IO page table base is no longer
held in the device context table. Instead it is held in the PASID table
entry pointed by the RID_PASID field in the device context entry. If
RID_PASID = 0, then it is the same as ARM and AMD IOMMUs.
You can refer to ch3.4.3 of the VT-d spec.
