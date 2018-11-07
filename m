From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Nov 2018 10:51:19 +0000
Subject: [PATCH 06/15] Bluetooth: hci_bcm: Simplify clk_get error handling
In-Reply-To: <20181107101308.7626-7-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-7-wens@csie.org>
Message-ID: <20181107105119.GT30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:12:59PM +0800, Chen-Yu Tsai wrote:
> @@ -911,6 +911,10 @@ static int bcm_get_resources(struct bcm_device *dev)
>  	if (IS_ERR(dev->clk) && PTR_ERR(dev->clk) == -EPROBE_DEFER)

You can also simplify the above test to:

	if (dev->clk == ERR_PTR(-EPROBE_DEFER))

as error pointers are uniquely different from normal pointers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
