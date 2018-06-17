From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 17 Jun 2018 14:47:23 +0100
Subject: [arm-platforms:irq/fixes-4.19 23/23]
 drivers/irqchip/irq-gic-v3-its.c:2335:13: error: 'nr_cpu_idx' undeclared;
 did you mean 'nr_cpu_ids'?
In-Reply-To: <201806172046.o5ARazOK%fengguang.wu@intel.com>
References: <201806172046.o5ARazOK%fengguang.wu@intel.com>
Message-ID: <86zhzt7ces.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Jun 2018 13:10:48 +0100,
kbuild test robot <lkp@intel.com> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/fixes-4.19
> head:   2e077035935196976aa09ec043257efd56519810
> commit: 2e077035935196976aa09ec043257efd56519810 [23/23] irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2e077035935196976aa09ec043257efd56519810
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/irqchip/irq-gic-v3-its.c: In function 'its_irq_domain_activate':
> >> drivers/irqchip/irq-gic-v3-its.c:2335:13: error: 'nr_cpu_idx' undeclared (first use in this function); did you mean 'nr_cpu_ids'?
>      if (cpu >= nr_cpu_idx) {
>                 ^~~~~~~~~~
>                 nr_cpu_ids
>    drivers/irqchip/irq-gic-v3-its.c:2335:13: note: each undeclared identifier is reported only once for each function it appears in

My bad, I pushed out the wrong branch, with the broken version of the
patch (Yang's patch was correct). Now fixed and pushed out again.

Thanks for the heads up.

	M.

-- 
Jazz is not dead, it just smell funny.
