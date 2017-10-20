From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Oct 2017 18:00:06 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.15 (#1)
In-Reply-To: <877evp6dir.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 20 Oct 2017 17:32:28 +0200")
References: <877evp6dir.fsf@free-electrons.com>
Message-ID: <87376d6c8p.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This email was sent in double because I though I had an issue with the
first send. Indeed an other email sent 15 min later to the same mailing
list showed up on the mailing list whereas this one was not there after
half an hour.

I don't understand what happened. Sorry for the noise,

Gregory


 
 On ven., oct. 20 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> Here is the first pull request for dt64 for mvebu for v4.15.
>
> Gregory
>
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.15-1
>
> for you to fetch changes up to c4e3bf290c3089502ee33e25795075b86fe9a449:
>
>   arm64: dts: marvell: 7040-db: Add the carrier detect pin for SD card on CP (2017-10-12 15:53:47 +0200)
>
> ----------------------------------------------------------------
> mvebu dt64 for 4.15 (part 1)
>
> On Armada 7K/8k:
> - Improve network support at SoC and board level
> - Enable watchdog
> - Add UART muxing
> - On 7040 DB: add CD SDIO and NAND support
> - On 8040 DB: add PCIE more ports and SPI1
>
> On Armada 37xx:
>  - Fix UART register size
>  - Add vmmc regulator for SD on 3720 DB
>
> ----------------------------------------------------------------
> Antoine Tenart (8):
>       arm64: dts: marvell: extend the cp110 syscon register area length
>       arm64: dts: marvell: add comphy nodes on cp110 master and slave
>       arm64: dts: marvell: cp110: add PPv2 port interrupts
>       arm64: dts: marvell: 37xx: remove empty line
>       arm64: dts: marvell: mcbin: add comphy references to Ethernet ports
>       arm64: dts: marvell: 7040-db: add comphy reference to Ethernet port
>       arm64: dts: marvell: 7040-db: enable the SFP port
>       arm64: dts: marvell: 8040-db: enable the SFP ports
>
> Baruch Siach (1):
>       arm64: dts: marvell: enable AP806 watchdog
>
> Christine Gharzuzi (1):
>       arm64: dts: marvell: Enable Armada-8040-DB CPS SPI1
>
> Gregory CLEMENT (4):
>       arm64: dts: marvell: armada-3720-db: Add vmmc regulator for SD slot
>       arm64: dts: marvell: add NAND support on the 7040-DB board
>       arm64: dts: marvell: 7040-db: Document the gpio expander
>       arm64: dts: marvell: 7040-db: Add the carrier detect pin for SD card on CP
>
> Thomas Petazzoni (2):
>       arm64: dts: marvell: add UART muxing on Armada 7K/8K
>       arm64: dts: marvell: enable additional PCIe ports on Armada 8040 DB
>
> allen yan (1):
>       arm64: dts: marvell: Fix A37xx UART0 register size
>
>  .../devicetree/bindings/serial/mvebu-uart.txt      |  2 +-
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 11 ++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  3 +-
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 55 +++++++++++++++++++-
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi       | 14 +++++
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 57 +++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 11 ++++
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 11 ++++
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 59 +++++++++++++++++++---
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 58 ++++++++++++++++++---
>  10 files changed, 261 insertions(+), 20 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
