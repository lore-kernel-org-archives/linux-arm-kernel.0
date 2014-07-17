From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 09:52:41 +0200
Subject: [GIT PULL] AT91 reset and ramc rework, DT additions
Message-ID: <20140717075241.GA28874@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Just like you asked here is a pull request for the rework of the
poweroff/reset additions patches I sent earlier.

This also have the patches you acked about the RAM controller
additions Alexandre did, that have some non-trivial merge issues.

Thanks,
Maxime

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/at91-dt-for-3.17

for you to fetch changes up to 16aa7f1f173f3ca105296cf2709cb039c99ffe4a:

  ARM: at91/dt: sama5d3: Add shutdown controller (2014-07-15 14:52:12 +0200)

----------------------------------------------------------------
AT91 ramc and reset/poweroff related DT patches

This branch gathers a few devicetree patches needed for the reworks found in
the later patches to be sent. More precisely, it holds:
  - The addition of ddrck for the sama5d3 and the sam9 SoCs
  - The addition of the shutdown controller node in the sama5d3 DTSI
  - The slight rework of the ramc bindings for the SoCs that have several RAM
    controllers

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91/dt: sama5d3: define mpddr clock and ramc clocks
      ARM: at91/dt: at91sam9: use ddrck in ramc

Maxime Ripard (2):
      ARM: at91/dt: Declare a second ram controller when relevant
      ARM: at91/dt: sama5d3: Add shutdown controller

 arch/arm/boot/dts/at91sam9263.dtsi | 10 +++++++---
 arch/arm/boot/dts/at91sam9g45.dtsi |  8 ++++++--
 arch/arm/boot/dts/at91sam9n12.dtsi |  2 ++
 arch/arm/boot/dts/at91sam9x5.dtsi  |  2 ++
 arch/arm/boot/dts/sama5d3.dtsi     | 14 +++++++++++++-
 5 files changed, 30 insertions(+), 6 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/7b6776d4/attachment.sig>
