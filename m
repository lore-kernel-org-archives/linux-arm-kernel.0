From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jul 2014 03:52:44 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <1406418436-61452-1-git-send-email-yahoo@perenite.com>
References: <1406418436-61452-1-git-send-email-yahoo@perenite.com>
Message-ID: <20140727015244.GA31974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit

> +			i2c at 11000 {
> +				compatible = "marvell,mv78230-a0-i2c",
> +					"marvell,mv64xxx-i2c";

The point of my patches is that you don't need the
"marvell,mv78230-a0-i2c". It will work out at runtime if the SoC is A0
stepping and automatically enable the workaround. Please test with
only "marvell,mv64xxx-i2c";

     Andrew
