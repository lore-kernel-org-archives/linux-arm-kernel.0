From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Tue, 3 Jun 2014 21:36:34 +0530
Subject: Fwd: [PATCH 0/4] arm:dma-mapping Refactoring iommu dma-mapping code
Message-ID: <CAD15agYD+fEjqR+fn5KoJoQwgc0O2tP8oL7dKtxM5FqCWsuDBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry about the spam, I guess due to HTML format, delivery failed to
arm mailing list.
So re-sending this.


++ for reviewing.

Hi Will,

Thanks for reviewing this.

On Tue, Jun 3, 2014 at 6:31 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Jun 02, 2014 at 11:19:19AM +0100, ritesh.harjani at gmail.com wrote:
> > From: Ritesh Harjani <ritesh.harjani@gmail.com>
> > Hi All,
>
> Hi Ritesh,
>
> Thanks for the new patches. I have a few comments on the series as a whole.
>
> > This patch series is to refractor iommu related common code from
> > arch/arm/dma-mapping.c to lib/iommu-helper.c based on the various
> > discussions with the maintainers/experts [1].
> >
> > Currently the only user of the common lib/iommu-helper code will
> > be ARM & ARM64 but later various architecture might try to use this
> > iommu lib helper functions.
> >
> > Major change of this refactoring starts with bringing out struct dma_iommu_mapping
> > *mapping variable from arch/arm/include/asm/device.h to include/linux/device.h
> > and by moving out complete structure defination of dma_iommu_mapping to
> > inclue/linux/iommu-helper.h. Link [2] give more details on why this was done,
> > also this change got approval from Will Daecon [2].
>
> Well, I can't approve changes to include/linux/device.h, so that probably
> needs to be acked by Grant and/or Greg. Could you split that patch out into
> a separate change please, so that it can go in independently?

Yes, I think what you are asking here is done as part of patch [1/4],
which are changes to include/linux/device.h
"arm: dma-iommu: Move out dma_iommu_mapping struct".

Did you mean something else here, when you said to have a independent
patch for this ? I guess path [1/4] does what you are asking. Please
let me know if I missed something here.

>
> Also, I think you could merge patches 2 and 3, no?

I did this so that reviewers don't have a large change to review. I
guess I got suggestions for this earlier.
But if you still insist I can merge the changes ?

>
>
> > There are 1/2 more function definitions which I can think of moving out, but
> > those can be done once this patch series is approved as those are not very
> > big changes.
>
> This certainly looks good to start with, although I think you should
> consider renaming the functions in the helper library so that they aren't
> prefixed with double underscores. Maybe iommu_helper_* instead?

Ok, I did had iommu_lib* routine in my earlier raw patch series to get
some comments, on which Arnd commented if I better drop those lib_
prefix. If I only have iommu_ prefix it confuses with drivers/iommu.c.
(http://lists.linuxfoundation.org/pipermail/iommu/2014-March/007837.html)

Ok, so I will better have iommu_helper prefix in the v2 patch series.
Please comment if anyone have objections on this.

>
> Finally, please drop the ChangeId entries from your commit messages (and

Yes, forgot to remove this. Sorry about that.

>
> you've consistently misspelled refactor as refractor).

Yes, my bad I keep getting confused between these two words. I will
fix this as well in v2.

>
>
> Will


Thanks
Ritesh
