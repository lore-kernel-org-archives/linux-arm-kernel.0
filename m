From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 29 Mar 2017 15:18:07 +0000
Subject: [GIT PULL] STi DT update for v4.12 round 1
Message-ID: <cea82671-d127-d207-0dc5-c60bff321c3f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.12 :

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
sti-dt-for-v4.12-round1

for you to fetch changes up to 6eb0d80d1df364bbb31d869e66063ca239912cbf:

   ARM: dts: STiH407-family: update rproc node names to avoid conflict 
(2017-03-29 17:07:14 +0200)

----------------------------------------------------------------

STi dts update:

Some SPI nodes are missing address-cells and size-cells. This is
causing warning at device tree compilation when some SPI device
sub-nodes are defined.

update rproc node names to avoid conflict, the two st231-rproc
nodes have the same name. Due to that it was impossible to
distinguish them in remoteproc sysfs and debugfs interface.

----------------------------------------------------------------
Loic Pallardy (1):
       ARM: dts: STiH407-family: update rproc node names to avoid conflict

Patrice Chotard (1):
       ARM: dts: STiH407-family: fix spi nodes

  arch/arm/boot/dts/stih407-family.dtsi | 18 ++++++++++++++++--
  1 file changed, 16 insertions(+), 2 deletions(-)
