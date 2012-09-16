From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Sep 2012 09:46:52 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <1347550912-18021-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120916074652.GM28177@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
> @@ -0,0 +1,279 @@
> +* Marvell Kirkwood SoC pinctrl driver for mpp
> +
> +Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
> +part and usage.
> +
> +Required properties:
> +- compatible: "marvell,88f6180-pinctrl",
> +              "marvell,88f6190-pinctrl", "marvell,88f6192-pinctrl",
> +              "marvell,88f6281-pinctrl", "marvell,88f6282-pinctrl"
> +
> +This driver supports all kirkwood variants, i.e. 88f6180, 88f619x, and 88f628

Hi Sebastian 

The current MPP code determines for itself what chip it is running on.
It can then check if a pin configuration is valid for the current
run time environment.

Here you are suggesting we have to put into the DT what chip we expect
to be on.

What is the advantage of this, over getting the information from the
device itself?

If i wanted to mass convert all existing kirkwood DT boards over to
use pinctrl, im stuck at the very first step. I've no idea what chip
they use, it was not relevant before.

Thanks
	Andrew
