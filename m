From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 22 Mar 2013 14:53:37 +0100
Subject: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
In-Reply-To: <1363959568-16976-1-git-send-email-florian@openwrt.org>
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363959568-16976-1-git-send-email-florian@openwrt.org>
Message-ID: <20130322145337.3814fcc8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 22 Mar 2013 14:39:24 +0100, Florian Fainelli wrote:
> Hi all,
> 
> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
> instead of rolling its own implementation. As a result, all users of this
> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
> The mvmdio driver is also updated to support an interrupt line which reports
> SMI error/completion, and to allow traditionnal platform device registration
> instead of just device tree.
> 
> David, I think it makes sense for you to merge all of this, since we do
> not want the architecture files to be desynchronized from the mv643xx_eth to
> avoid runtime breakage. The potential for merge conflicts should be very small.
> 
> Florian Fainelli (4):
>   net: mvmdio: allow platform device style registration
>   net: mvmdio: rename base register cookie from smireg to regs
>   net: mvmdio: enhance driver to support SMI error/done interrupts
>   mv643xx_eth: convert to use the Marvell Orion MDIO driver

For the entire series:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

tested on:

 * Armada XP DB, DT-based, which uses the mvneta driver. It is affected
   by the 3 first commits since Armada XP also uses the mvmdio driver.

 * Kirkwood development board, non-DT, which uses the mv643xx_eth
   driver.

Thanks Florian for this work,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
