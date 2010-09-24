From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 24 Sep 2010 10:40:11 -0600
Subject: [PATCH 0/3] OMAP: hwmod/device/CM: bug fixes for 2.6.37
Message-ID: <20100924163936.19418.47065.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are a few bugfix patches for the omap_hwmod, omap_device,
and CM code, intended to be merged in 2.6.37 via Tony's tree.
 
This series applies on top of the 2.6.37 hwmod patches sent earlier;
unfortunately the third patch touches the same code as a patch in that
series, so this series can't be based on v2.6.36-rc5.


- Paul

---

   text	   data	    bss	    dec	    hex	filename
3361500	 176832	  99336	3637668	 3781a4	vmlinux.omap_4430sdp_defconfig.orig
3361468	 176832	  99336	3637636	 378184	vmlinux.omap_4430sdp_defconfig.patched

Hema HK (1):
      OMAP: hwmod: Set autoidle after smartidle during _sysc_enable

Kishon Vijay Abraham I (1):
      OMAP: omap_device: Fix to support multiple hwmods for a single device

Rajendra Nayak (1):
      OMAP4: PM: Declare idle modules as functional too


 arch/arm/mach-omap2/cm4xxx.c     |    9 +++++----
 arch/arm/mach-omap2/omap_hwmod.c |   17 +++++++++++------
 arch/arm/plat-omap/omap_device.c |   35 ++++++++++++++---------------------
 3 files changed, 30 insertions(+), 31 deletions(-)
