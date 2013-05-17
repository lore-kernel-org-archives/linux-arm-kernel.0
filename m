From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 09:28:16 +0100
Subject: [PATCH] drm/i2c: nxp-tda998x: fix abort of some i2c exchanges
In-Reply-To: <20130517083803.5f34816e@armhf>
References: <20130517083803.5f34816e@armhf>
Message-ID: <20130517082816.GY18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 08:38:03AM +0200, Jean-Francois Moine wrote:
> The signals SIGALRM (most often) and SIGPOLL (sometimes) may be raised
> after irq or some parameter change and this aborts the i2c exchanges.
> 
> The problem is solved by masking these signals.

NAK.  The real problem is in the I2C driver, which actually suffers from
multiple problems.  See the set of I2C patches I posted yesterday.
