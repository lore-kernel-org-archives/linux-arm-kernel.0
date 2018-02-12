From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Mon, 12 Feb 2018 08:55:41 +0100
Subject: [shawnguo:imx/dt 1/42] Error:
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts:19.1-2 syntax error
In-Reply-To: <201802121532.20rd85VM%fengguang.wu@intel.com>
References: <201802121532.20rd85VM%fengguang.wu@intel.com>
Message-ID: <bdfa3a5f-a942-374d-acfb-2cd7e8bde8ff@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-02-12 08:42, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/dt
> head:   4ce917f8d003453415200c6be13b74ba4676ddeb
> commit: d287e28b2c909bf99a4aac5eb98521247b476517 [1/42] ARM: dts: ls1021a: add nodes for on-chip ram
> config: arm-at91_dt_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d287e28b2c909bf99a4aac5eb98521247b476517
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts:19.1-2 syntax error
>>> FATAL ERROR: Unable to parse input tree
> --
>>> Error: arch/arm/boot/dts/ls1021a-qds.dts:51.1-2 syntax error
>>> FATAL ERROR: Unable to parse input tree
> --
>>> Error: arch/arm/boot/dts/ls1021a-twr.dts:51.1-2 syntax error
>>> FATAL ERROR: Unable to parse input tree

Seems to be a rebase-induced error. The can3 node in imx/dt has lost its
closing brace.

Rasmus
