From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jun 2018 10:51:14 +0100
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: enable spi flash
In-Reply-To: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
References: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
Message-ID: <20180628095113.GC17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 10:13:35AM +0300, Baruch Siach wrote:
> The SolidRun Armada 388 SOM has the SPI flash populated by default
> unless the customer explicitly asks otherwise. Enable support by
> default.

Are you sure about that - at least some of my boards do not have the
SPI flash populated.

&spi1 {
        /* The microsom has an optional W25Q32 on board, connected to CS0 */
...
&spi1 {
        /*
         * Add SPI CS pins for clearfog:
         * CS0: W25Q32 (not populated on uSOM)
         * CS1: PIC microcontroller (Pro models)
         * CS2: mikrobus
         */

I wouldn't have written "not populated on uSOM" without having first
taken the uSOM off and physically checked.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
