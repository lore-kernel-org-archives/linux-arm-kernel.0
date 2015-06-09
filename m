From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jun 2015 18:53:00 +0200
Subject: [PATCH 23/34] pinctrl: mvebu: armada-xp: rename spi to spi0
In-Reply-To: <1433868446-11028-24-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-24-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150609165300.GA16778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 06:47:15PM +0200, Thomas Petazzoni wrote:
> After updating to the latest Armada XP datasheet, we discovered that
> there is a second SPI bus accessible from the MPP pins, called 'spi1'.
> 
> In order to be consistent with other SoCs having two SPI busses, this
> commit renames the functions of the first SPI bus to 'spi0' instead of
> just 'spi'.
> 
> This commit obviously breaks the DT backward compatibility for the
> people using the "spi" function name in their Device Tree.

Hi Thomas

Should this patch also contain a change to armada-xp.dtsi:

        spi0_pins: spi0-pins {
                marvell,pins = "mpp36", "mpp37",
                               "mpp38", "mpp39";
                marvell,function = "spi";
        };

	Andrew
