From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 Aug 2016 21:32:45 +0530
Subject: [PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst areas
In-Reply-To: <b8c09619-22a5-a677-8841-9760c275a618@denx.de>
References: <201608241240.aEXnCS9C%fengguang.wu@intel.com>
 <b8c09619-22a5-a677-8841-9760c275a618@denx.de>
Message-ID: <20160830160245.GK9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 10:23:02AM +0200, Stefan Roese wrote:
> On 24.08.2016 06:16, kbuild test robot wrote:
> > Hi Stefan,
> > 
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v4.8-rc3 next-20160823]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> > [Check https://git-scm.com/docs/git-format-patch for more information]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Stefan-Roese/dmaengine-mv_xor-Add-support-for-IO-PCIe-src-dst-areas/20160817-175632
> > config: xtensa-allyesconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 4.9.0
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=xtensa 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/built-in.o: In function `set_param_ifnum':
> >>> ipmi_poweroff.c:(.text+0x10157c): undefined reference to `mvebu_mbus_get_io_win_info'
> >    drivers/built-in.o: In function `mv_xor_add_io_win':
> >    mv_xor.c:(.text+0x11039e): undefined reference to `mvebu_mbus_get_io_win_info'
> 
> Does it really make sense to compile this driver for all archs?
> Or should I send a v2 of this patch that removes COMPILE_TEST for
> this driver from Kconfig so that its only compiled for the
> target platforms?

Compile test is helpful :) 

If it is reasonable possible, that I would urge you to keep it.

-- 
~Vinod
