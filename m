From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 15:37:13 +0100
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <50DDAD68.4090704@openwrt.org>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <50DDAD68.4090704@openwrt.org>
Message-ID: <20121228143713.GB5172@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 03:32:08PM +0100, Florian Fainelli wrote:
> Hello Andrew,
> 
> Le 12/28/12 13:47, Andrew Lunn a ??crit :
> >Move the Kirkwood cpuidle driver out of arch/arm/mach-kirkwood and
> >into drivers/cpuidle. Convert the driver into a platform driver and
> >add a device tree binding. Add a DT node to instantiate the driver for
> >boards converted to DT, and a platform data for old style boards.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >---
> 
> [snip]
> 
> >
> >+/*****************************************************************************
> >+ * CPU idle
> >+ ****************************************************************************/
> >+static struct resource kirkwood_cpuidle_resource[] = {
> >+	{
> >+		.flags	= IORESOURCE_MEM,
> >+		.start	= DDR_OPERATION_BASE,
> >+		.end	= 3,
> 
> Should not this be DDR_OPERATION_BASE + 3?

Yes it should.

Thanks
	Andrew
