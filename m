From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 9 Jun 2011 15:53:01 -0500
Subject: [PATCH v2 3/5] net: ep93xx_eth: allocate buffers using kmalloc()
In-Reply-To: <7b20107efa24e0a0c956663ddc70b2189f64c04b.1307040443.git.mika.westerberg@iki.fi>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
	<7b20107efa24e0a0c956663ddc70b2189f64c04b.1307040443.git.mika.westerberg@iki.fi>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3820B8616@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 02, 2011 12:00 PM, Mika Westerberg wrote:
>
> We can use simply kmalloc() to allocate the buffers. This also simplifies the
> code and allows us to perform DMA sync operations more easily.
>
> Memory is allocated with only GFP_KERNEL since there are no DMA allocation
> restrictions on this platform.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks ok to me.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
