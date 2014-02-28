From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 21:03:01 +0100
Subject: [PATCH 7/7] PCI: designware: split samsung and fsl bindings
In-Reply-To: <1393608523-17509-8-git-send-email-l.stach@pengutronix.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <1393608523-17509-8-git-send-email-l.stach@pengutronix.de>
Message-ID: <201402282103.01897.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014, Lucas Stach wrote:
> +Required properties:
> +- compatible: "fsl,imx6q-pcie"
> +- reg: base addresse and length of the pcie controller
> +- interrupts: First entry must contain interrupt handle for controller
> +  INTA output.

I think this should be documented as "optional" and only for
backwards compatibility with old kernels.

> +- clocks: Must contain an entry for each entry in clock-names.
> +       See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries: 
> +       - "pcie_ref_125m"
> +       - "sata_ref_100m"
> +       - "lvds_gate"
> +       - "pcie_axi"

I don't understand why you have completely different clocks here
from the exynos documentation. The clock names should really be
the same. Also, why do you have a "sata_ref_100m" clock?
Is this just driving a device that happens to be on-board
for a specific machine? Same for the "lvds_gate".

	Arnd
