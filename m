From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 15 Mar 2013 12:42:10 +0100
Subject: [PATCH 4/4 v2] mv643xx_eth: convert to use the Marvell Orion
 MDIO driver
In-Reply-To: <514300E0.2030108@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-5-git-send-email-florian@openwrt.org>
 <514300E0.2030108@openwrt.org>
Message-ID: <20130315124210.27d0794a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Fri, 15 Mar 2013 12:07:12 +0100, Florian Fainelli wrote:

> Thanks to the help of Andrew Lunn, there is at least two known issues 
> with this patch version:
> 
> - we need to move up the mvmdio line in 
> drivers/net/ethernet/marvell/Makefile to make sure that configs having 
> both mvmdio and mv643xx_eth built-in get the probing order right

I don't think it's the right way of fixing the problem. If there is no
dependency on the two devices through the device model (i.e they don't
have a parent->child relationship), then the mv643xx_eth driver should
probably return -EPROBE_DEFER when it can't find its PHY so that its
->probe() operation gets called once again by the kernel when other
drivers (including mvmdio) have been probed.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
