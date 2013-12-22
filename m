From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Dec 2013 10:40:47 +0100
Subject: [PATCH 1/5] Documentation: APM X-Gene SoC Ethernet DTS binding
 documentation
In-Reply-To: <1387597376-29303-2-git-send-email-isubramanian@apm.com>
References: <1387597376-29303-1-git-send-email-isubramanian@apm.com>
 <1387597376-29303-2-git-send-email-isubramanian@apm.com>
Message-ID: <201312221040.47822.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 December 2013, Iyappan Subramanian wrote:
> @@ -0,0 +1,67 @@
> +APM X-Gene SoC Ethernet nodes
> +
> +Ethernet nodes are defined to describe on-chip ethernet interfaces in
> +APM X-Gene SoC. Ethernet subsystem communicates with a central Queue Manager
> +(QMTM) using messages for transmit, receive and allocating data buffers.
> +There are multiple ethernet interfaces in APM X-Gene SoC. Each ethernet
> +interface has its own node. Its corresponding clock nodes are shown below.
> +
> +Required properties:
> +- compatible		: Shall be "apm,xgene-enet"
> +- reg			: First memory resource shall be the Ethernet CSR
> +			  memory resource for indirect MAC access.
> +			  Second memory resource shall be the Ethernet CSR
> +			  memory resource.
> +			  Third memory resource shall be the Ethernet CSR
> +			  memory resource for indirect MII access.

What is a "CSR"?

> +- interrupts		: First interrupt resource shall be the Ethernet global
> +			  Error interrupt.
> +			: Second interrupt resource shall be the Ethernet MAC
> +			  Error interrupt.
> +			: Third interrupt resource shall be the Ethernet QM
> +			  interface interrupt.

No regular interrupts?

> +- clocks		: Reference to the clock entry.
> +- local-mac-address	: Shall be ethernet mac address.
> +- max-frame-size	: Shall be maximum ethernet frame size.
> +- devid			: Shall be ethernet interface number.
> +- phyid			: Shall be ethernet MII phy address.
> +- phy-mode		: Shall be ethernet MII mode.

Can you explain what the interface number is for?

Is the phy actually part of the ethernet device? Since it has its
own register range, it seems likely that it's actually a separate
device that just happens to be used together with the mac and should
have its own device node and driver.

	Arnd
