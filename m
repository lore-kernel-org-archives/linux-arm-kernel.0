From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 8 Sep 2016 17:21:00 +0200
Subject: [RESEND GIT PULL] STi DT fixes for v4.8-rcs
Message-ID: <f2d83529-3ab1-fe8e-c599-cf5dfbb1f17b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

I resend this pull request as i got issue with the local IT infrastructure.

Please consider this set for inclusion into the v4.8-rcs.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-fixes-for-v4.8-rcs

for you to fetch changes up to 78567f135d9bbbaf4538f63656d3e4d957c35fe9:

  ARM: dts: STiH407-family: Provide interconnect clock for consumption in ST SDHCI (2016-09-08 15:51:12 +0200)

----------------------------------------------------------------
Handle STiH410 interconnect clock required for EHCI/OHCI and SDHCI

With the introduction of critical-clock support in v4.8, our developers'
default configuration is to run with 'clk_ignore_unused' removed.  This
patch-set ensures they can achieve successful boot when a) booting from
an SD Card and when b) booting using USB->Eth adaptors for NFS booting.

----------------------------------------------------------------
Lee Jones (2):
      ARM: dts: STiH410: Handle interconnect clock required by EHCI/OHCI (USB)
      ARM: dts: STiH407-family: Provide interconnect clock for consumption in ST SDHCI

 arch/arm/boot/dts/stih407-family.dtsi | 10 ++++++----
 arch/arm/boot/dts/stih410.dtsi        | 12 ++++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)
