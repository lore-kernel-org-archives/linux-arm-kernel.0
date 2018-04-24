From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Apr 2018 18:05:47 +0800
Subject: [v2 08/10] clk: mediatek: mt8173-mm: switch to mfd device
In-Reply-To: <74bf4058534cf187e10ef041da1706878914aa45.1524497268.git.mbrugger@suse.com>
References: <74bf4058534cf187e10ef041da1706878914aa45.1524497268.git.mbrugger@suse.com>
Message-ID: <201804241638.leHWZOjv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.17-rc2 next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/matthias-bgg-kernel-org/arm-arm64-mediatek-Fix-mmsys-device-probing/20180424-013521
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x501416): Section mismatch in reference from the function mtk_mmsys_probe() to the variable .init.rodata:mm_clks
   The function mtk_mmsys_probe() references
   the variable __initconst mm_clks.
   This is often because mtk_mmsys_probe lacks a __initconst
   annotation or the annotation of mm_clks is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62881 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/00fa906b/attachment-0001.gz>
