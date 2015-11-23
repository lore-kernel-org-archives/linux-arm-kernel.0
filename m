From: fengguang.wu@intel.com (Fengguang Wu)
Date: Mon, 23 Nov 2015 12:42:43 +0800
Subject: [arm:drm-etnaviv-devel 3/149]
 drivers/staging/etnaviv/etnaviv_iommu.c:96:8: error: 'struct iommu_domain'
 has no member named 'priv'
In-Reply-To: <20151116184106.GA8644@n2100.arm.linux.org.uk>
References: <201511170205.1DddFiK9%fengguang.wu@intel.com>
 <20151116184106.GA8644@n2100.arm.linux.org.uk>
Message-ID: <20151123044243.GB15973@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 06:41:06PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 17, 2015 at 02:30:06AM +0800, kbuild test robot wrote:
> > tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
> > head:   77c57a5498ebe5c85b4a71fbcf800a9140f9a697
> > commit: b920a1d21ac9c12ddb174daca7d99ab81d791ad6 [3/149] staging: etnaviv: add drm driver
> > config: i386-randconfig-r0-201546 (attached as .config)
> > reproduce:
> >         git checkout b920a1d21ac9c12ddb174daca7d99ab81d791ad6
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > Note: the arm/drm-etnaviv-devel HEAD 77c57a5498ebe5c85b4a71fbcf800a9140f9a697 builds fine.
> >       It only hurts bisectibility.
> 
> It's great that this is getting some testing, but it doesn't need to be
> on a per-commit basis as this is a development branch for this driver.

OK.

> The failing commit is a consolidation commit of Christian's work which
> has been forward-ported across different kernel versions (and will
> remain so.)  So, each time I forward-port this branch, you're going
> to hit the same error but with a different commit ID.

FYI the robot will auto ignore already reported errors. So rebase
won't trigger duplicate reports. Anyway I've disabled per-commit
testing for this branch.

> As it's someone elses work, I won't be merging a fix into the commit.
> 
> The other point is that the branch as it stands will never be going into
> the mainline kernel: when the driver does get merged, it will be as a
> very small number of consolidated patches.
> 
> It does make sense to build-test the branch head commit though.

OK.

Thanks,
Fengguang
