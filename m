From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 23:00:05 +0200
Subject: [GIT PULL 2/6] Broadcom devicetree changes for 4.14
In-Reply-To: <20170817183748.1450-3-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-3-f.fainelli@gmail.com>
Message-ID: <CAK8P3a0yk_DXYWHJB=ad3VeMcMpnY_pem-bRAcO6dQCLP6fW6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 8:37 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/devicetree
>
> for you to fetch changes up to 0173b2cd6948b5b96ac4e8dbc3bcb4dd0b45c296:
>
>   ARM: BCM53573: Specify ports for USB LED for Tenda AC9 (2017-08-17 10:18:07 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree changes for
> 4.14, please pull the following:
>
> - Eric moves the bcm2837 DT file from arm64 to arm because it created a maintenance
>   problem and would have required either duplication or cross merges
>
> - Stefan changes how the pinmuxing is defined and pushes it at the board level
>   to support Raspberry Pi Zero Wireless. He then adds supports for the actual
>   Raspberry Pi Zero Wireless board along with binding documentation. Stefan
>   also defines a proper SMP enable-method property and binding for BCM2836
>   (Raspbery Pi 2)
>
> - Rafal describes the BCM5301X USB ports correctly in Device Tree such that
>   it becomes possible to assign them to specific LED triggers (e.g: USB activity).
>   He does the same thing for BCM53573 and defines default LED triggers for USB.
>
> - Jon provides a fix for Northstar Plus which consists in correctly defining
>   the "dma-coherent" property for peripherals which are DMA coherent. He also
>   does a bit of re-arrangement of the USB DT nodes and finally adds USB 3 PHY
>   and host controller support for NorthStar Plus
>
> - Florian adds support for Broadcom's BCM947189ACDBMR reference board which is
>   based on BCM47182/53573 and which supports external MoCA (BCM6802)
>
> - Ray fixes the wrong UART2 base address for Cygnus
>
> - Scott moves the v3d node in the proper unit address order and defines the correct
>   UART alias for the BCM91130_entphn reference board to be UART3
>
> - Jason adds the DT node for the Cygnus Cortex-A9 Performance Monitoring Unit
>
> - Jonathan adds a bunch of additional peripherals to the Cygnus DTS include file:
>   SDHCI, Keypad, SPI, DMA and pinmux configurations
>
> - Raveendra adds the Cygnus OHCI and EHCI Device Tree nodes

Pulled into next/dt, thanks!

     Arnd
