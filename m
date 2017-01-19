From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jan 2017 16:30:25 -0800
Subject: [GIT PULL 1/2] Broadcom devicetree changes for 4.11
In-Reply-To: <20170118012931.10964-1-f.fainelli@gmail.com>
References: <20170118012931.10964-1-f.fainelli@gmail.com>
Message-ID: <20170119003025.GL23725@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 05:29:30PM -0800, Florian Fainelli wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.11/devicetree
> 
> for you to fetch changes up to d72b156515f60ac1f765fc024e93777e19ef8fda:
> 
>   Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next (2017-01-17 17:10:32 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC Device Tree changes for 4.11,
> please pull the following changes:
> 
> - Rafal enables the UART by default on all BCM5301x, BCM4708, BCM4709 since
>   every device found out there has it enabled by default. He also fixes the
>   LED definitions for the Luxul XWR-3100 device, enables USB controllers and
>   their respective PHY devices, specifies the correct GPIO to power on USB
>   HUBs, adds the additional RAM bank for somes devices, and finally sets the
>   correct 5Ghz frequency limits on the Netgear R8000
> 
> - Jon does a number of Norsthar Plus SoC cleanups, fixes NAND partitions unit
>   addresses, adds QSPI support to a bunch of boards, adds Ethernet switch ports
>   to the BCM958625K reference board, enables 3rd Ethernet MAC instance to
>   relevant DTSes, enables Ethernet on the XMC board, and finally adds SD/MMC
>   support to the XMC board
> 
> - Boris adds the Video Encoder nodes to the Raspberry Pi DTS include files
>   ands enables it on the relevant boards
> 
> - Dan adds support for two new Luxul devices: XAP-1410 and XWR-1200, both
>   BCM47081 based SoCs
> 
> ----------------------------------------------------------------
> Boris Brezillon (2):
>       ARM: bcm/dt: Add VEC node in bcm283x.dtsi
>       ARM: bcm/dt: Enable the VEC IP on all RaspberryPi boards
> 
> Dan Haab (2):
>       ARM: BCM5301X: Add DT for Luxul XAP-1410
>       ARM: BCM5301X: Add DT for Luxul XWR-1200
> 
> Florian Fainelli (1):
>       Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next
> 
> Jon Mason (7):
>       ARM: dts: NSP: DT Clean-ups
>       ARM: dts: NSP: Correct NAND partition unit address
>       ARM: dts: NSP: Add QSPI support to missing boards
>       ARM: dts: NSP: Add BCM958625K switch ports
>       ARM: dts: NSP: Add and enable amac2
>       ARM: dts: NSP: Add Ethernet to NSP XMC
>       ARM: dts: NSP: Add SD/MMC support
> 
> Rafa?? Mi??ecki (7):
>       ARM: BCM5301X: Enable UART by default for BCM4708(1), BCM4709(4) & BCM53012
>       ARM: BCM5301X: Fix LAN LED labels for Luxul XWR-3100
>       ARM: BCM5301X: Specify USB controllers in DT
>       ARM: BCM5301X: Set GPIO enabling USB power on Netgear R7000
>       ARM: BCM5301X: Specify all RAM by including an extra block
>       ARM: BCM53573: Specify USB ports of on-SoC controllers
>       ARM: BCM5301X: Set 5 GHz wireless frequency limits on Netgear R8000

Jon gets a passing grade, the rest gets F on patch subject formats.

When in doubt, look at git log --oneline of arch/arm/boot/dts and see
what others use. It's:

ARM: dts: <platform>: <change description>


Please respin.


-Olof
