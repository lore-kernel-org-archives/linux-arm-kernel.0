From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 02 Feb 2015 14:20:19 +0100
Subject: [PATCH v5 0/9] Enable HDMI support on Exynos platforms
Message-ID: <1422883228-10690-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is yet another update on patchset, which enables HDMI support for
Exynos based platforms.

Beside DTS changes, this patchset adds parent domain support for Exynos
PM domains and add support for 'hdmi' clock directly to Exynos DRM mixer
driver.

The patchset is based on samsung/for-next branch and 'PM / Domains:
Export of_genpd_get_from_provider function' patch merged as commit
7496fcbe8a643097efc061160e1c3b65ee2fa350 to v3.19-rc4.

Regards
Marek Szyprowski


Changelog:

v5:
- fixed error value for clk_get() in mixer patch
- rebased onto samsung/for-next branch

v4: (http://www.spinics.net/lists/linux-samsung-soc/msg41375.html)
- added patches, which add 'hdmi' clock handling to mixed block, this
  finally solves the initialization related issues, thanks for Tobias
  Jakobi for testing
- added acks/reviewed/tested by tags

v3: (http://www.spinics.net/lists/linux-samsung-soc/msg41020.html)
- added a note on defining subdomains to generic PM domain binding
  documentation (requested by Ulf Hansson)

v2: (http://www.spinics.net/lists/linux-samsung-soc/msg40980.html)
- rewrote subdomains patch according to suggestions from Geert
  Uytterhoeven and Amit Daniel Kachhap.

v1 resend: (http://www.spinics.net/lists/linux-samsung-soc/msg39428.html)
- added handling of generic 'power-domains' binding in subdomains

v1: (http://www.spinics.net/lists/linux-samsung-soc/msg38914.html)
- resolved power domain on/off issue with 'clk: samsung: exynos4: set
  parent of mixer gate clock to hdmi' patch

v0: (http://www.spinics.net/lists/linux-samsung-soc/msg33498.html)
- first attempt, used 'always on' power domains hack


Patch summary:


*** BLURB HERE ***

Andrzej Hajda (1):
  ARM: dts: exynos5250: add display power domain

Marek Szyprowski (7):
  PM / Domains: Add a note about power domain subdomains
  ARM: Exynos: add support for sub-power domains
  ARM: dts: exynos4: add hdmi related nodes
  ARM: dts: exynos4: add dependency between TV and LCD0 power domains
  ARM: dts: exynos4412-odroid: enable hdmi support
  ARM: dts: Exynos: add 'hdmi' clock to mixer nodes
  drm/exynos: add support for 'hdmi' clock

Tomasz Stanislawski (1):
  ARM: dts: exynos4210-universal_c210: enable hdmi support

 .../bindings/arm/exynos/power_domain.txt           |  2 +
 .../devicetree/bindings/power/power_domain.txt     | 29 +++++++++++
 .../devicetree/bindings/video/exynos_mixer.txt     |  1 +
 arch/arm/boot/dts/exynos4.dtsi                     | 41 ++++++++++++++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts    | 57 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  8 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 44 +++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi                  | 11 +++++
 arch/arm/boot/dts/exynos5250.dtsi                  | 15 +++++-
 arch/arm/boot/dts/exynos5420.dtsi                  |  5 +-
 arch/arm/mach-exynos/pm_domains.c                  | 28 +++++++++++
 drivers/gpu/drm/exynos/exynos_mixer.c              |  9 ++++
 12 files changed, 246 insertions(+), 4 deletions(-)

-- 
1.9.2
