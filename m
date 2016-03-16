From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 16 Mar 2016 17:42:05 +0100
Subject: [RFC PATCH 0/2] of: Implement iterator for phandles
Message-ID: <1458146527-1133-1-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here is an implementation of the iterator over phandles
concept which Rob Herring suggested to me some time ago. My
approach is a little bit different from what the diff showed
back then, but it gets rid of the allocation and 'struct
'struct of_phandle_args' misuse.

I also converted the arm-smmu driver to make use of the
iterator. The resulting kernel boots on my AMD Seattle
system and fixes the warning triggered there.

There is still some work to to on this change, but it would
be cool to get some early feedback on the code and the
direction it takes. Here is also my todo-list for this
before next submission:

TODO:

* Reorder members of 'struct of_phandle_iterator' and do
  some renaming and documentation of them.

* Split up first patch to make it easier to review and
  bisect.

* Re-add and update some comments which got lost during the
  conversion.

Any feedback is appreciated.

Thanks,

	Joerg

Joerg Roedel (2):
  of: Implement iterator for phandles
  iommu/arm-smmu: Make use of phandle iterators in device-tree parsing

 drivers/iommu/arm-smmu.c |  27 ++++--
 drivers/of/base.c        | 219 +++++++++++++++++++++++++++--------------------
 include/linux/of.h       |  95 ++++++++++++++++++++
 3 files changed, 241 insertions(+), 100 deletions(-)

-- 
1.9.1
