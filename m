From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Apr 2013 07:09:27 +0900
Subject: [GIT PULL] Late Exynos stuff for v3.10
In-Reply-To: <5176B499.1000208@samsung.com>
References: <5176B499.1000208@samsung.com>
Message-ID: <51770697.7080504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/13 01:19, Kukjin Kim wrote:
> The following changes since commit
> 58a7bbf75442ea439a4d3b7993ad87023e406063:
>
> ARM: dts: add PDMA0 changes for exynos5440 (2013-04-09 01:39:27 +0900)
>
> are available in the git repository at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/late-exynos-for-v3.10
>
> for you to fetch changes up to 9007025f3438ec3bdea02439e760585345102b8d:
>
> ARM: dts: Disable the RTC by default on exynos5 (2013-04-24 00:32:28 +0900)
>
> ----------------------------------------------------------------
> This includes late exynos stuff for v3.10 1) keypad for smdk4412 and
> origen4412 boards 2) adds mfc clock entries for exynos4 3) enables
> usb2phy, usb3phy and dwc3-exynos for exynos5250 4) enables tmu for
> exynos4210 5) support chip id with dt
>
> ----------------------------------------------------------------
> Doug Anderson (1):
> ARM: dts: Disable the RTC by default on exynos5
>
> Girish K S (1):
> ARM: EXYNOS: force MAC ip to 32bit DMA
>
> Sachin Kamat (7):
> ARM: dts: Remove keypad entries from exynos4x12-pinctrl.dtsi
> ARM: dts: Add keypad entries to Exynos4412 based Origen
> ARM: dts: Add keypad entries to SMDK4412
> ARM: dts: Add MFC clock entries for exynos4
> ARM: dts: Update MFC documentation for clock entries
> ARM: dts: Add TMU clock entries to exynos4210.dtsi
> ARM: dts: Enable TMU on Origen4210 board
>
> Thomas Abraham (4):
> ARM: dts: add mshc controller node for Exynos4x12 SoCs
> ARM: EXYNOS: Add a platform bus notifier to set dma masks for Exynos5440
> ARM: EXYNOS: Create virtual I/O mapping for Chip-ID controller using
> device tree
> ARM: dts: Add chip-id controller node on Exynos4/5 SoC
>
> Vivek Gautam (5):
> ARM: dts: Enabling samsung-usb2phy driver for exynos5250
> ARM: dts: Enabling samsung-usb3phy driver for exynos5250
> ARM: dts: Add device tree bindings for dwc3-exynos
> ARM: dts: Enabling dwc3-exynos driver for exynos5250
> ARM: EXYNOS: Enable XHCI support on exynos5
>
> .../devicetree/bindings/media/s5p-mfc.txt | 5 ++
> .../devicetree/bindings/usb/exynos-usb.txt | 34 +++++++++
> arch/arm/boot/dts/exynos4.dtsi | 7 ++
> arch/arm/boot/dts/exynos4210-origen.dts | 4 +
> arch/arm/boot/dts/exynos4210.dtsi | 3 +
> arch/arm/boot/dts/exynos4412-origen.dts | 62 +++++++++++++++
> arch/arm/boot/dts/exynos4412-smdk4412.dts | 87 ++++++++++++++++++++++
> arch/arm/boot/dts/exynos4412.dtsi | 8 ++
> arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 56 --------------
> arch/arm/boot/dts/exynos5250.dtsi | 51 +++++++++++++
> arch/arm/boot/dts/exynos5440.dtsi | 1 +
> arch/arm/mach-exynos/Kconfig | 1 +
> arch/arm/mach-exynos/common.c | 53 +++++++------
> arch/arm/mach-exynos/include/mach/map.h | 1 -
> arch/arm/mach-exynos/mach-exynos5-dt.c | 28 +++++++
> 15 files changed, 321 insertions(+), 80 deletions(-)
>
> Hi Arnd and Olof,
>
> As I said, last my pull-request at 4/10 included most of above changes.
> So would be nice if you could pull this and small patches added on top
> of that though.
>
> If any problems, please kindly let me know.
>
Arnd, Olof,

Since above request should be too late, so I did sort out like 
following. I think, it should be fine to you ;-) Sorry for noise.

Note that others will be queued for v3.11.

Thanks.

- Kukjin

  The following changes since commit 
58a7bbf75442ea439a4d3b7993ad87023e406063:

    ARM: dts: add PDMA0 changes for exynos5440 (2013-04-09 01:39:27 +0900)

  are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
  tags/late-exynos-v2-for-v3.10

  for you to fetch changes up to 1ec583759692013c4576d557904b595e9f3953dd:

    ARM: dts: Disable the RTC by default on exynos5 (2013-04-24 06:58:21 
+0900)

  ----------------------------------------------------------------
  This includes late exynos stuff for v3.10 and 2nd version for pull 
request 1) enables usb2phy, usb3phy and dwc3-exynos for exynos5250 2) 
support chip id with dt

  ----------------------------------------------------------------
  Doug Anderson (1):
        ARM: dts: Disable the RTC by default on exynos5

  Thomas Abraham (3):
        ARM: dts: add mshc controller node for Exynos4x12 SoCs
        ARM: EXYNOS: Create virtual I/O mapping for Chip-ID controller 
using device tree
        ARM: dts: Add chip-id controller node on Exynos4/5 SoC

  Vivek Gautam (5):
        ARM: dts: Enabling samsung-usb2phy driver for exynos5250
        ARM: dts: Enabling samsung-usb3phy driver for exynos5250
        ARM: dts: Add device tree bindings for dwc3-exynos
        ARM: dts: Enabling dwc3-exynos driver for exynos5250
        ARM: EXYNOS: Enable XHCI support on exynos5

   .../devicetree/bindings/usb/exynos-usb.txt         | 34 ++++++++++++++
   arch/arm/boot/dts/exynos4.dtsi                     |  5 ++
   arch/arm/boot/dts/exynos4412.dtsi                  |  8 ++++
   arch/arm/boot/dts/exynos5250.dtsi                  | 51 
+++++++++++++++++++++
