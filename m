From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 10 Jun 2011 19:55:45 +0300
Subject: [PATCH v2 2/5] net: ep93xx_eth: pass struct device to DMA API
	functions
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3820B8699@AUSP01VMBX24.collaborationhost.net>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
	<c0ddfc297e0ea1e64e58cedd6552c6b2e52c5fe8.1307040443.git.mika.westerberg@iki.fi>
	<ADE657CA350FB648AAC2C43247A983F001F3820B8699@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110610165545.GA2753@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 06:40:21PM -0500, H Hartley Sweeten wrote:
> 
> I just noticed this macro in include/linux/netdevice.h
> 
> /* Set the sysfs physical device reference for the network logical device
>  * if set prior to registration will cause a symlink during initialization.
>  */
> #define SET_NETDEV_DEV(net, pdev)       ((net)->dev.parent = (pdev))
> 
> Is there anyway you could use that macro in the probe to save the platform_device
> (with it's associated device) instead of introducing a new struct device * in the
> private data?

Nice finding, thanks.

I'll look into that and send new version of the whole series soon.
