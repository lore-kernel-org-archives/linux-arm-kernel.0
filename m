From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 16:32:42 +0100
Subject: [PATCH 1/5] net: mvmdio: unmap base register address at driver
 removal
In-Reply-To: <1359473048-26551-2-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-2-git-send-email-florian@openwrt.org>
Message-ID: <20130129163242.1df2caf5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Tue, 29 Jan 2013 16:24:04 +0100, Florian Fainelli wrote:
> Fix the driver remove callback to unmap the base register address and
> not leak this mapping after the driver has been removed.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

What about using devm_request_and_ioremap() instead, in order to get
automatic unmap on error and in the ->remove() path?

But maybe it won't work because this memory range is claimed both by
the MDIO driver and the Ethernet driver itself. In that case, you could
use devm_ioremap().

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
