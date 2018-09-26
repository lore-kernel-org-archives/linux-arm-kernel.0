From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 26 Sep 2018 11:53:49 +0530
Subject: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
In-Reply-To: <20180925163928.GA1839@brain-police>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180925120933.54xd72sv65d63tkl@8bytes.org>
 <20180925163928.GA1839@brain-police>
Message-ID: <CAFp+6iEdyBKcQ=ikOaqJGHcmsjWJdDMWGgzFdW54aSqpQ-EE3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 10:09 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Sep 25, 2018 at 02:09:34PM +0200, Joerg Roedel wrote:
> > On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> > > Vivek Gautam (4):
> > >   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
> > >   firmware/qcom_scm: Add atomic version of io read/write APIs
> > >   firmware/qcom_scm: Add scm call to handle smmu errata
> > >   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> > >
> > >  drivers/firmware/qcom_scm-32.c |  17 ++++
> > >  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
> > >  drivers/firmware/qcom_scm.c    |  18 ++++
> > >  drivers/firmware/qcom_scm.h    |   9 ++
> > >  drivers/iommu/arm-smmu-regs.h  |   2 +
> > >  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
> > >  include/linux/qcom_scm.h       |   6 ++
> > >  7 files changed, 320 insertions(+), 46 deletions(-)
> >
> > Should this go through the iommu-tree? In that case I need Acked-by's
> > for the firmware code changes.
>
> Yup, and I'd also like Robin's ack on the arm-smmu*.c changes (I see he has
> some comments on the code as it stands).

Thanks Joerg, and Will for taking a look at it. I will answer and
address Robin's comments
for smmu part.

Best regards
Vivek

>
> Will
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
