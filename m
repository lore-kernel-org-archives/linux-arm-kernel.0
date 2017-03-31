From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 12:04:59 +0200
Subject: [GIT PULL 2/7] Broadcom devicetree changes for 4.12
In-Reply-To: <20170324175807.27272-2-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
 <20170324175807.27272-2-f.fainelli@gmail.com>
Message-ID: <CAK8P3a1brEnF6nDpDLMGN4CN5TYL4z23doa03APTh4LQyFiSuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 6:58 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/devicetree
>
> for you to fetch changes up to 414ce21ae20547e0eea72fe0c4e8ee3280d30888:
>
>   Merge tag 'bcm2835-dt-next-2017-03-21' into devicetree/next (2017-03-24 10:12:31 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree updates for
> 4.12, please pull the following:
>
> - Rafal:
>
>         * adds basic support for the Linksys EA9200, Linksys EA6300 V1, Linksys
>           EA9500, TP-Link Archer C5 V2 which are all based on BCM470x SoCs with
>           a bunch of BCM43602 radios.
>
>         * updates the BCM5301X DTS and DTS include file and moves the serial
>           console parameters to the DTS include file since all BCM5301X that we have so
>           far are consistent in using the same UART. He also does the same for the
>           BCM53573 DTS.
>
>         * makes some updates to the Tenda AC9 platform by describing its
>           PCIe controllers and endpoints in order to be able to represent GPIOs attached
>           to the on-chip Wi-Fi module. Once done, he adds the 2Ghz LED which is connected
>           to one of these GPIOs.
>
>         * re-licenses the DTS files he created to the ISC license
>
>         * removes the use of the non-existend "default-off" LED trigger in the
>           BCM53573 and BCM5301X DTS files
>
> - Aditya adds missing Netgear R8000 LEDS and keys for WAN status LEDS and brightness
>
> - Jon:
>         * adds NAND controller Device Tree nodes to the BCM953012K reference board
>
>         * converts the BCM5301X SoC to use the recently introduced Broadcom QSPI controller
>           Device Tree nodes.
>
>         * fixes the GIC PPI interrupt flags that the kernel now
>           reports about.
>
>         * adds ARM TWD watchdog entries to the BCM5301X DTS include file
>         * adds I2C entries to the BCM5301X DTS include files.
>
>         * disables i2c by default in the Northstar Plus DTS include file, and
>          ,enables it at the board level instead.
>
>         * adds USB (OHCI & EHCI) Device Tree nodes to the Northstar Plus DTS
>           include files.
>
> - Steven adds the mailbox (PDC) unit and the crytographic unit (SPU) to the
>   Broadcom Northstar Plus SoC DTS include file. Steven also adds proper ethernet
>   aliases to the BCM53012HR board since some bootloaders require that for MAC address
>   patching.
>
> - Eric adds the DSI and its corresponding clock nodes to the BCM283x DTS files
>   but leaves them disabled by default (overlays should take care of enabling it)
>
> - Boris adds support for HDMI audio and related DMA channels to the BCM283x SoCs
>
> - Gerd adds support for the BCM2835 specific SDHCI controller to the BCM283x SoCs
>
> - Rob fixes the iProc msi-controller name and unit address now that DTC can produce
>   additional errors


Pulled into next/dt, thanks!

      Arnd
