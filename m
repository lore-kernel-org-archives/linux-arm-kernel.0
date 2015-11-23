From: fengguang.wu@intel.com (Fengguang Wu)
Date: Mon, 23 Nov 2015 12:40:09 +0800
Subject: [arm:drm-etnaviv-devel 89/149]
 drivers/staging/etnaviv/etnaviv_gem_submit.c:263:19: error: 'struct
 drm_etnaviv_gem_submit_reloc' has no member named 'shift'
In-Reply-To: <20151120163544.GE8644@n2100.arm.linux.org.uk>
References: <201511210020.MaDgPArI%fengguang.wu@intel.com>
 <20151120163544.GE8644@n2100.arm.linux.org.uk>
Message-ID: <20151123044009.GA15973@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, done!

On Fri, Nov 20, 2015 at 04:35:44PM +0000, Russell King - ARM Linux wrote:
> It seems that my request to _not_ test individual commits in this
> branch are not being heeded...
> 
> On Sat, Nov 21, 2015 at 12:15:21AM +0800, kbuild test robot wrote:
> > tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
> > head:   77c57a5498ebe5c85b4a71fbcf800a9140f9a697
> > commit: 11c90396fe41eb9d232018c47d89da4080c375d2 [89/149] staging: etnaviv: clean up public API
> > config: i386-randconfig-r0-201546 (attached as .config)
> > reproduce:
> >         git checkout 11c90396fe41eb9d232018c47d89da4080c375d2
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > Note: the arm/drm-etnaviv-devel HEAD a0252118653cb935f209bd8baf048195c77d3292 builds fine.
> >       It only hurts bisectibility.
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/staging/etnaviv/etnaviv_gem_submit.c: In function 'submit_reloc':
> > >> drivers/staging/etnaviv/etnaviv_gem_submit.c:263:19: error: 'struct drm_etnaviv_gem_submit_reloc' has no member named 'shift'
> >       if (submit_reloc.shift || submit_reloc.or) {
> >                       ^
> > >> drivers/staging/etnaviv/etnaviv_gem_submit.c:263:41: error: 'struct drm_etnaviv_gem_submit_reloc' has no member named 'or'
> >       if (submit_reloc.shift || submit_reloc.or) {
> >                                             ^
> > 
> > vim +263 drivers/staging/etnaviv/etnaviv_gem_submit.c
> > 
> > b920a1d2 Christian Gmeiner 2014-09-27  257  				(off < last_offset)) {
> > b920a1d2 Christian Gmeiner 2014-09-27  258  			DRM_ERROR("invalid offset %u at reloc %u\n", off, i);
> > b920a1d2 Christian Gmeiner 2014-09-27  259  			return -EINVAL;
> > b920a1d2 Christian Gmeiner 2014-09-27  260  		}
> > b920a1d2 Christian Gmeiner 2014-09-27  261  
> > 80ddbc50 Russell King      2014-10-21  262  		/* Vivante hardware has no need for shifts or bitwise or-ing */
> > 80ddbc50 Russell King      2014-10-21 @263  		if (submit_reloc.shift || submit_reloc.or) {
> > 80ddbc50 Russell King      2014-10-21  264  			DRM_ERROR("invalid shift or bitwise or at reloc %u\n",
> > 80ddbc50 Russell King      2014-10-21  265  				  i);
> > 80ddbc50 Russell King      2014-10-21  266  			return -EINVAL;
> > 
> > :::::: The code at line 263 was first introduced by commit
> > :::::: 80ddbc5081a66ab9d3d494044ddbe3a7c94efbed staging: etnaviv: remove shifting and bitwise or-ing of GPU addresses
> > 
> > :::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
> > :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
