From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Nov 2018 09:30:37 -0800
Subject: [PATCH 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
In-Reply-To: <1542108563-10108-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-2-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <20181113173036.GA2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:29:24AM +0000, Andrei.Stefanescu at microchip.com wrote:

> +- lpm-gpio: GPIO for LPM pin. Note that this GPIO *must* remain high during
> +	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.

All GPIO properties should be -gpios even if they can only ever have one
GPIO.

> +- regulators: A node that houses a sub-node for each regulator within
> +              the device. Each sub-node is identified using the node's
> +              name. The content of each sub-node is defined by the
> +              standard binding for regulators; see regulator.txt.

You should describe which regulators exist for the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/a80a64a4/attachment.sig>
