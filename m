From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Feb 2014 12:27:33 +0000
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <3871646.18hjUjnpmg@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <20140213144106.GW26684@n2100.arm.linux.org.uk> <1626419.Ta3A7zgHIt@wuerfel>
 <3871646.18hjUjnpmg@wuerfel>
Message-ID: <20140215122733.GK30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 01:18:02PM +0100, Arnd Bergmann wrote:
> If a wlan adapter has both SPI and SDIO front-ends, the external
> dependencies (reset, clock, voltage, ...) will be the same, and
> from the kernel perspective the main difference is that SPI cannot
> be probed at all, while SDIO can be probed as long as the device
> is powered on already.

Remember that MMC/SD/SDIO cards can be driven by either a MMC host
interface, or a SPI interface.  Both are probe-able.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
