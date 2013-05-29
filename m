From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 29 May 2013 16:00:53 -0400
Subject: [PATCH v5 01/13] net: mv643xx_eth: use phy_disconnect instead
 of phy_detach
In-Reply-To: <1369855975-21489-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130529200053.GA31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, May 29, 2013 at 09:32:43PM +0200, Sebastian Hesselbarth wrote:
> Using a separated mdio bus driver with mvmdio, phy_detach on network device
> removal will not stop the phy and finally lead to NULL pointer dereference
> in mvmdio due to non-existent network device. Use phy_disconnect instead
> to properly stop phy device from accessing network device prior removal of
> the network device.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Note: I observed this behavior when removing a modular mv643xx_eth driver
> after attaching it to a phy handled by (also modular) mvmdio. The mvmdio
> conversion has been done in
> 
> commit c3a07134e6aa5b93a37f72ffa3d11fadf72bf757
>  ("mv643xx_eth: convert to use the Marvell Orion MDIO driver")
> 
> and should go back any -stable version with that commit (propably only 3.9)

It looks like just v3.10-rcX, here.

thx,

Jason.
