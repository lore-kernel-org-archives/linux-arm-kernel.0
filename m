From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jan 2018 16:05:17 +0000
Subject: [PATCH 2/2] arm64: dts: marvell: mcbin: enable uart headers
In-Reply-To: <97a7416bb0eb19c9d32e41984e292a869ff14230.1517299286.git.baruch@tkos.co.il>
References: <1ebd25aace6c9ab93abe7fb6e42ef9e275eee321.1517299286.git.baruch@tkos.co.il>
 <97a7416bb0eb19c9d32e41984e292a869ff14230.1517299286.git.baruch@tkos.co.il>
Message-ID: <20180130160516.GE9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 10:01:26AM +0200, Baruch Siach wrote:
> Add description of the J25 and J27 UART headers of the Macchiatobin. They use
> uart peripherals that the CP0 (J25) and CP1 (J27) provides.

The headers are just fed with the GPIO-level signals, which means any
industry standard usage would require additional RS232 level shifting
hardware.  So, they're certainly not "generic" serial ports.

While these are labelled up as UARTs, there's no reason to dedicate
them as such, they could equally be used to connect to a smart battery/
UPS system as a SMBus port, or even to control system LEDs / read
the status of system buttons.

Do you have an application for these headers?  If not, it's probably
best to leave them alone (until we have DT overlay support sorted to
allow boot-loader configuration of hardware such as these - which is
being worked on for TI and other boards.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
