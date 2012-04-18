From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 18 Apr 2012 07:01:07 +0000
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <1334714869-19282-9-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334714869-19282-9-git-send-email-marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B766FD@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



 
> 
> This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I tried to
> keep
> this separate from the MXC EHCI to avoid further polution of the MXC EHCI,
> though eventually these two might be merged.
> 
As mxc and mxs platforms use the same USB controller (chipidea's), I wonder if
you can use ehci-mxc, or change name from ehci-mxc to ehci-imx?
Sascha, what's your opinion?

> NOTE: I still haven't figured out how to enable/disable the disconnection
> detector, it can't be enabled all the time, so I toggle PHY stuff from
> this
> driver, which I doubt is correct.
For HS disconnect detector, please use like below:
- When there is no device at port, disable it
- When there is a device on the port, enable it
- When bus suspend occurs, disable it
- When bus resume has finishes, enable it.

 
> +	/* Set up the PORTSCx register */
> +	ehci_writel(ehci, MXC_EHCI_MODE_ULPI, &ehci->regs->port_status[0]);
It is UTMI PHY, why you use ULPI mode?

 
