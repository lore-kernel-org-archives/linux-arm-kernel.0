From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 24 May 2014 15:13:32 +0530
Subject: [GIT PULL 01/02] DaVinci EDMA clean-up for v3.16
Message-ID: <1400924613-24451-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, Arnd,

These patches introduce a change to EDMA bindings. They
deprecate some bindings but new kernel will continue
to work with older DTBs since the information is now
read from hardware instead. I have not been able to
get an Ack/response from DT folks on this. Since it
has been close to two weeks since the patches were first
posted, I am asking for the patches to be merged so
we dont miss the merge window.

This pull request is on top of Vinod's topic/edma branch
which he has guaranteed will not be rebased before going
to Linus. This was needed because of dependency with some
patches he has queued.

This series introduces a trivial merge conflict with
Linux-next because of a bug fix which went in after
Vinod's branch was built.

Thanks,
Sekhar

The following changes since commit b0cce4ca3e740b5224d75634aa9d9abe9dfceabb:

  dmaengine: edma: update DMA memcpy to use new param element (2014-04-30 10:36:57 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.16/edma

for you to fetch changes up to 903ed4913c7fe78d2746445564634264291c7493:

  ARM: edma: Remove redundant/unused parameters from edma_soc_info (2014-05-22 14:55:25 +0530)

----------------------------------------------------------------
This series makes edma use configuration
information available within the IP instead
of reading it from platform data or DT. Some
other useful clean-ups are included too.

----------------------------------------------------------------
Peter Ujfalusi (14):
      ARM: edma: Clean up and simplify the code around irq request
      ARM: edma: No need to clean the pdata in edma_of_parse_dt()
      ARM: edma: Take the number of tc from edma_soc_info (pdata)
      ARM: edma: Do not change TC -> Queue mapping, leave it to default.
      ARM: davinci: Remove eDMA3 queue_tc_mapping data from edma_soc_info
      ARM: edma: Remove queue_tc_mapping data from edma_soc_info
      ARM: edma: Remove num_cc member from struct edma
      ARM: edma: Save number of regions from pdata to struct edma
      ARM: edma: Get IP configuration from HW (number of channels, tc, etc)
      dt/bindings: ti,edma: Remove redundant properties from documentation
      ARM: dts: am33xx: Remove obsolete properties from edma node
      ARM: dts: am4372: Remove obsolete properties from edma node
      ARM: davinci: Remove redundant/unused parameters for edma
      ARM: edma: Remove redundant/unused parameters from edma_soc_info

 Documentation/devicetree/bindings/dma/ti-edma.txt |   13 +-
 arch/arm/boot/dts/am33xx.dtsi                     |    3 -
 arch/arm/boot/dts/am4372.dtsi                     |    3 -
 arch/arm/common/edma.c                            |  175 ++++++++++-----------
 arch/arm/mach-davinci/devices-da8xx.c             |   31 ----
 arch/arm/mach-davinci/dm355.c                     |   14 --
 arch/arm/mach-davinci/dm365.c                     |   16 --
 arch/arm/mach-davinci/dm644x.c                    |   14 --
 arch/arm/mach-davinci/dm646x.c                    |   16 --
 include/linux/platform_data/edma.h                |    8 -
 10 files changed, 93 insertions(+), 200 deletions(-)
