From: guodong.xu@linaro.org (Guodong Xu)
Date: Sun, 18 Jun 2017 15:06:01 +0800
Subject: [PATCH v2 3/5] arm64: dts: Add ufs dts node
In-Reply-To: <201706180814.Kte2462z%fengguang.wu@intel.com>
References: <20170616065119.10704-4-butao@hisilicon.com>
 <201706180814.Kte2462z%fengguang.wu@intel.com>
Message-ID: <CAFGCpxwKjvNAj1yVqstBmtxBexwpRrcPo+F3XJP9j-CZhuH0MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 18, 2017 at 8:31 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Bu,
>
> [auto build test ERROR on mkp-scsi/for-next]
> [also build test ERROR on v4.12-rc5 next-20170616]
> [cannot apply to robh/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>

It applies to:
 git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.13-v2

> url:    https://github.com/0day-ci/linux/commits/Bu-Tao/scsi-ufs-add-ufs-driver-code-for-Hi3660-SoC/20170618-045141
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>>> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:152.24-25 syntax error
>    FATAL ERROR: Unable to parse input tree

UFS node has a dependency on clock node <&crg_ctrl ...>, which is
submitted in another patchset [1]. [1] has been Ack'ed by platform
maintainer Wei Xu, and is available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.13-v2

[1] hi3660-hikey960 dts base:
https://www.spinics.net/lists/kernel/msg2533737.html

-Guodong


>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
