From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Mar 2015 06:21:56 +0000 (UTC)
Subject: amba: tegra-ahb: fix base address and register offsets for future
 chip support
In-Reply-To: <20150320061102.14355.4781.stgit@mcwayne>
References: <20150320061102.14355.4781.stgit@mcwayne>
Message-ID: <alpine.DEB.2.02.1503200616040.23726@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks

On Fri, 20 Mar 2015, Paul Walmsley wrote:

> This series has been boot-tested on Tegra20 Trimslice, Tegra30
> Beaver, Tegra114 Dalmore, Tegra124 Jetson TK1, Tegra132 Norrin64
> FFD (with a few additional out-of-tree patches, since T132
> support is not yet upstream), and QEMU Versatile Express 64.
> Basic build and boot test logs for T30, T114, T124, and QEMU
> Versatile Express 64 are here:
> 
> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150317011136_159e7763d517804c61a673736660a5a35f2ea5f8/20150317011136/

The above paragraph was accurate for the initial version of this series.  
But for this third version, the testing is a little different.  Here's 
what the paragraph should have read:

---
This series has been boot-tested on Tegra20 Trimslice, Tegra30 Beaver, 
Tegra114 Dalmore, Tegra124 Jetson TK1, and QEMU Versatile Express 64. 
Basic build and boot test logs for T20, T30, T114, T124, and QEMU 
Versatile Express 64 are here:

http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150319225643_e8444885428c4257999e632eff35e8e8c8a8b504/20150319225643
---

The test summary is included below.  

Sorry for the extra noise; I'm still working out some bugs in my NVIDIA 
patch-posting toolchain, which unfortunately is more complicated than it 
should be.

The rest of the original message is accurate.


- Paul



Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build: Image:
    Pass: ( 1/ 1): defconfig

Boot to userspace: defconfig:
    Pass: ( 1/ 1): qemu-vexpress64

Boot to userspace: multi_v7_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 4/ 4): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra20-trimslice, tegra30-beaver
