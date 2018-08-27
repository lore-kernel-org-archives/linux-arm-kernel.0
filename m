From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2018 23:26:46 +0100
Subject: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <20180827200344.16158-2-f.fainelli@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
Message-ID: <20180827222646.GF30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 01:03:42PM -0700, Florian Fainelli wrote:
> Enable the SFP connected to port 5 of the switch and wire up all GPIOs
> to the SFP cage. Because of a hardware limitation of the i2c controller
> on the iProc SoCs which prevents large i2c (> 256 bytes) transactions to
> work, we use the i2c-gpio interface instead, which does not have that
> limitation. This allows us to read the SFP module EEPROM, which would
> not be possible otherwise since it exceeds that size during a single
> read transfer.

We shouldn't exceed 256 bytes, since 256 bytes is the "page" size
of the EEPROM.  The most that we read in one block is either
ETH_MODULE_SFF_8079_LEN or (ETH_MODULE_SFF_8472_LEN - 
ETH_MODULE_SFF_8079_LEN), both of which result in no more than 256
byte reads.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
