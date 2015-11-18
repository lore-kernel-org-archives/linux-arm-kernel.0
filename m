From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Nov 2015 11:24:52 -0800
Subject: [PATCH 2/4] arm64: dts: Add msm8996 SoC and MTP board support
In-Reply-To: <201511181303.U0nlsppa%fengguang.wu@intel.com>
References: <201511181303.U0nlsppa%fengguang.wu@intel.com>
Message-ID: <564CD084.1080902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2015 09:06 PM, kbuild test robot wrote:
> Hi Stephen,
>
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.4-rc1 next-20151117]
>
> url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/devicetree-bindings-Document-Kryo-cpu/20151118-091558
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
> config: arm64-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi:14:0,
>                     from arch/arm64/boot/dts/qcom/msm8996-mtp.dts:16:
>>> arch/arm64/boot/dts/qcom/msm8996.dtsi:14:48: fatal error: dt-bindings/clock/qcom,gcc-msm8996.h: No such file or directory
>     #include <dt-bindings/clock/qcom,gcc-msm8996.h>
>                                                    ^
>    compilation terminated.
>

Yes. These patches depend on the clk patches that expose that header
file. We'll have to pull in the clock branch underneath the dts branch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
