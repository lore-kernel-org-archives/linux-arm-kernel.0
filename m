From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 19 Nov 2016 22:04:54 -0600
Subject: [arm-soc:qcom/arm64 3/13] Error:
 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi:12.20-21 syntax error
In-Reply-To: <201611181938.YpOhQOad%fengguang.wu@intel.com>
References: <201611181938.YpOhQOad%fengguang.wu@intel.com>
Message-ID: <20161120040454.GC16531@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 07:01:40PM +0800, kbuild test robot wrote:
> Hi Srinivas,
> 
> FYI, the error/warning still remains.

Ok, I see what happened.  I included the dt-bindings file in the drivers pull
erroneously.  This should have gone in the ARM64 DTS pull.  As such it will work
when all pulls are together, but not when done as a single unit.  My apologies
for mixing this up.


Andy

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
> head:   feeaf56ac78d283efe65ea60ec999d4bf3cf395e
> commit: 50784e61032d89cbbc46ed73a5fb15f27940b947 [3/13] dts: arm64: db820c: add pmic pins specific dts file
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 50784e61032d89cbbc46ed73a5fb15f27940b947
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi:12.20-21 syntax error
>    FATAL ERROR: Unable to parse input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
