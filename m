From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 18 Nov 2016 10:47:38 -0600
Subject: [arm-soc:qcom/arm64 13/13]
 arch/arm64/boot/dts/qcom/msm8994.dtsi:14:48: fatal error:
 dt-bindings/clock/qcom,gcc-msm8994.h: No such file or directory
In-Reply-To: <201611182005.RuBSvaJ7%fengguang.wu@intel.com>
References: <201611182005.RuBSvaJ7%fengguang.wu@intel.com>
Message-ID: <20161118164738.GA16531@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 08:20:07PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
> head:   feeaf56ac78d283efe65ea60ec999d4bf3cf395e
> commit: feeaf56ac78d283efe65ea60ec999d4bf3cf395e [13/13] arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout feeaf56ac78d283efe65ea60ec999d4bf3cf395e
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts:16:0:
> >> arch/arm64/boot/dts/qcom/msm8994.dtsi:14:48: fatal error: dt-bindings/clock/qcom,gcc-msm8994.h: No such file or directory
>     #include <dt-bindings/clock/qcom,gcc-msm8994.h>

So I completely forgot to add the point that the 8994 dt-include information is
coming in through the clk-tree.  We've been working with a immutable branch and
both will land for the next rc1.  As such this hasn't been a problem in next,
but it will be for arm-soc for standalone testing.

Andy
