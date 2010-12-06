From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 15:26:09 +0000
Subject: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
In-Reply-To: <AANLkTim641hqqyCczMPN_rDvVH_dqV0voQLFhQsrQLY3@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
	<AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
	<20101202152053.GC10461@n2100.arm.linux.org.uk>
	<AANLkTi=01qGO6pX15n_w-W4RaaXsK3u697UQ9pD_DuvW@mail.gmail.com>
	<AANLkTim641hqqyCczMPN_rDvVH_dqV0voQLFhQsrQLY3@mail.gmail.com>
Message-ID: <20101206152609.GA3701@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 09:16:23AM -0600, Kanigeri, Hari wrote:
> Ruseell,
> 
> On Thu, Dec 2, 2010 at 9:43 AM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
> > On Thu, Dec 2, 2010 at 9:20 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernando wrote:
> >>> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
> >>> <linux@arm.linux.org.uk> wrote:
> >>> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
> >>> >> Hi Tony,
> >>> >>
> >>> >> The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:
> >>> >> ? Linus Torvalds (1):
> >>> >> ? ? ? ? Linux 2.6.37-rc4
> >>> >>
> >>> >> are available in the git repository at:
> >>> >>
> >>> >> ? git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38
> >>> >>
> >>> >> Fernando Guzman Lugo (5):
> >>> >> ? ? ? OMAP: mailbox: change full flag per mailbox queue instead of global
> >>> >> ? ? ? omap: iovmm - no gap checking for fixed address
> >>> >> ? ? ? omap: iovmm - add superpages support to fixed da address
> >>> >> ? ? ? omap: iovmm - replace __iounmap with omap_iounmap
> >>> >
> >>> > This change is wrong. ?Nothing should be directly referencing omap_iounmap
> >>> > nor for that matter omap_ioremap. ?Both are implementation details of the
> >>> > standard ioremap/iounmap APIs.
> >>> >
> >>> > Use the official APIs rather than the implementation details behind them.
> >>>
> >>> if you see where the function is used, you will see that it is not
> >>> calling the function, it is use as a parameter in unmap_vm_area(), if
> >>> I used iounmap which is a macro there I will get a compilation error.
> >>
> >> Hmm, yes, because iounmap() is defined as a macro rather than iounmap.
> >>
> >> The solution to this is to fix iounmap and __arch_iounmap macros so
> >> they aren't macros which take arguments. ?That will then allow them
> >> to be used in the way you desire.
> >
> > yes, that way it can be used in the function parameter. what is the
> > right thing to do?
> > 1) You send your patch and then I send the new version of the patches.
> > 2) I make a new series of the patches with the change to iounmap and I
> > include your patch in the series.
> >
> 
> Can you please suggest the approach we take here ? So, either you send
> your suggested change as a patch and Fernando's patch will be based on
> it, or he can take a TODO action item to patch again if you plan to
> send this change later.

I've not yet decided myself what to do about it, which is why I haven't
replied or even committed the patch myself - I've had the hotplug/SMP/gic
stuff to concentrate on during the latter half of last week _and_ the
weekend, so I've not had time to get back to this yet.
