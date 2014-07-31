From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 31 Jul 2014 13:55:09 +0200
Subject: [PATCH 0/2] Better model Peach Pit and PI power scheme
Message-ID: <1406807711-19955-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a small series that improve the modeling of the power
scheme on the Peach Pit and Pi boards. Besides making the DTS
to better describe the hardware these changes allows the core
regulator to know what's the real supply for a child to fetch
the parent output voltage if the child voltage is requested,
now that the regulator core allows to do that [0,1].

Patch 1 modifies the regulators input supply to use the real
parents instead of using a simplistic model and assume that
VDC is supplying power to all regulators and patch 2 defines
the maximum and minimum voltage constraints for the switches.

Javier Martinez Canillas (2):
  ARM: dts: Improve Peach Pit and Pi power scheme model
  ARM: dts: Add tps65090 FET constraints on Peach Pit and Pi

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 26 ++++++++++++++++++++------
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 26 ++++++++++++++++++++------
 2 files changed, 40 insertions(+), 12 deletions(-)

Best regards,
Javier

[0]: https://patchwork.kernel.org/patch/4641331/
[1]: https://patchwork.kernel.org/patch/4641311/
