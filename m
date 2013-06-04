From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 4 Jun 2013 10:34:13 +0800
Subject: [PATCH 0/2] ARM: multiple-platforms: fix the kernel panic on non-SiRF
 platforms
Message-ID: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches fix the kernel panic for multiple-platform kernel to run on non-SiRF
platforms.

It depends on patches I sent in the pull-request mail
[GIT PULL] SiRF fixes for the v3.10 series
at:
http://www.spinics.net/lists/arm-kernel/msg247521.html

And thanks for the original patchset from Srinivas Kandagatla <srinivas.kandagatla@st.com>

Barry Song (2):
  ARM:prima2: move sirfsoc_of_rstc_init to .init_machine
  ARM:prima2:drop postcore_initcalls in pm module

 arch/arm/mach-prima2/common.c | 10 ++++++++++
 arch/arm/mach-prima2/common.h |  1 +
 arch/arm/mach-prima2/pm.c     | 35 +++++++++++++++++++----------------
 arch/arm/mach-prima2/rstc.c   |  5 +----
 4 files changed, 31 insertions(+), 20 deletions(-)

-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
