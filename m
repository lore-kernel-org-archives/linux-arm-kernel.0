From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Sun, 26 Jun 2016 20:09:16 +0000
Subject: [PATCH v3 1/3] arm: tegra: initial support for apalis tk1
In-Reply-To: <201606261116.9IwjfA6i%fengguang.wu@intel.com>
References: <201606261116.9IwjfA6i%fengguang.wu@intel.com>
Message-ID: <1466971755.3308.3.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-06-26 at 11:52 +0800, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.7-rc4 next-20160624]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> 
> url:????https://github.com/0day-ci/linux/commits/Marcel-Ziswiler/arm-
> tegra-initial-support-for-apalis-tk1/20160619-091204
> base:???https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> for-next
> config: arm-tegra_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
> ????????wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tes
> ts.git/plain/sbin/make.cross -O ~/bin/make.cross
> ????????chmod +x ~/bin/make.cross
> ????????# save the attached .config to linux build tree
> ????????make.cross ARCH=arm?
> 
> All errors (new ones prefixed by >>):
> 
> ???ERROR (duplicate_label): Duplicate label 'pinmux' on /pinmux at 70000
> 868 and /pinmux at 0,70000868
> > 
> > > 
> > > ERROR: Input tree has errors, aborting (use -f to force output)
> ---
> 0-DAY kernel test infrastructure????????????????Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all???????????????????Intel
> Corporation

Yes, as stated under 'changes in v2' this depends on below patch as
well:

- remove commas from unit addresses as suggested by Rob (this requires
? the separate patch to clean up tegra124.dtsi as well as all the other
? boards basing on it to be applied first)

https://patchwork.kernel.org/patch/9185977/
