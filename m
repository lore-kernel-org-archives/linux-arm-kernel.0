From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Sun, 23 Feb 2014 11:52:42 -0800
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
Message-ID: <20140223195242.12998.36214@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lorenzo Pieralisi (2014-02-22 04:09:10)
> On Sat, Feb 22, 2014 at 10:38:40AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 19, 2014 at 04:12:54PM +0000, Lorenzo Pieralisi wrote:
> > > > + cpu_switch_mm(idmap_pgd, &init_mm);
> >
> > You need the idmap_pgd in place to call cpu_resume at it's physical
> > address.  Other page tables just won't do here.  It's well established
> > that this page table must be in place for the resume paths to work.
> 
> Well, we do not need idmap page tables for copying the restore_pblist,
> but we do need a set of tables that won't be corrupted by the copy and
> idmap does the trick (I was confused because 1:1 mappings are not needed
> for the copy itself).
> 
> The switch to idmap is done for us in soft_reboot anyway before jumping to
> cpu_resume and that's required, as you said.

Ok, so I'll leave the cpu_switch_mm as is for the next patchset.

Thanks Lorenzo, Russ and Russell!

Sebastian
