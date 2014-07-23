From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Jul 2014 00:42:36 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <1406154923-13612-2-git-send-email-yahoo@perenite.com>
References: <1406154923-13612-1-git-send-email-yahoo@perenite.com>
 <1406154923-13612-2-git-send-email-yahoo@perenite.com>
Message-ID: <20140723224236.GC28485@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +			i2c at 11000 {
> +				compatible = "marvell,mv78230-a0-i2c",
> +					"marvell,mv64xxx-i2c";

Ah sorry, i missed this first time. Do you really need
"marvell,mv78230-a0-i2c"?

Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt says:

                     - "marvell,mv78230-a0-i2c"
                       * Note: Only use "marvell,mv78230-a0-i2c" for a
                         very rare, initial version of the SoC which
                         had broken offload support.  Linux
                         auto-detects this and sets it appropriately.

So i don't think you should have this hear.

Gregory, please could you comment.

> +		power-led {
> +			label = "ix4-300d:power";

It is normal to include the colour, and you did for all the other
LEDs.

	Andrew
