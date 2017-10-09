From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 9 Oct 2017 16:26:02 +0200
Subject: [GIT PULL] at91: fixes for 4.14 #2
Message-ID: <20171009142602.8027-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A second batch of fixes for AT91, all about DT modifications. We discovered
the Ethernet phy issue lately and the ADC fixes are patches that we forgot
while converting sama5d2 ADC to use hardware triggers. The 2 ADC patches are
needed so that the driver can probe corectly again:
https://storage.kernelci.org/mainline/master/v4.14-rc2-255-g74d83ec2b734/arm/sama5_defconfig/lab-free-electrons/boot-at91-sama5d2_xplained.txt
It will certainly be the last "fixes" PR for this cycle.

Thanks, best regards,

The following changes since commit 093d79f62a89f47d9b5fd0746768146d9696535c:

  ARM: at91: Replace uses of virt_to_phys with __pa_symbol (2017-09-18 10:05:38 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes2

for you to fetch changes up to 27d90f46f253ccc7c5447f6fa62505acb1c246fe:

  ARM: dts: at91: sama5d2: add ADC hw trigger edge type (2017-10-09 15:34:22 +0200)

----------------------------------------------------------------
Fixes: second batch for 4.14:
- one DT phy address fix for the new sama5d27 som1 ek
- two DT ADC patches that were forgotten while moving to
  hardware triggers for sama5d2 (iio changes already applied)

----------------------------------------------------------------
Eugen Hristev (2):
      ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
      ARM: dts: at91: sama5d2: add ADC hw trigger edge type

Ludovic Desroches (1):
      ARM: dts: at91: at91-sama5d27_som1: fix PHY ID

 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   |  4 ++--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 +++++++++++++++-
 arch/arm/boot/dts/sama5d2.dtsi              |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
