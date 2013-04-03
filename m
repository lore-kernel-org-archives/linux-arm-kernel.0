From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Apr 2013 14:55:47 +0000
Subject: [PATCH v5 2/6] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <20130403134827.GF14680@arwen.pp.htv.fi>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
 <1364993634-6378-3-git-send-email-kishon@ti.com>
 <20130403134827.GF14680@arwen.pp.htv.fi>
Message-ID: <201304031455.47864.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 April 2013, Felipe Balbi wrote:
> const ? Maybe provide a:
> 
> #define DEFINE_PHY_OPS(name)    \
> const struct phy_ops #name_phy_ops = {
> 
> macro ? This will force people to add the const keyword :-)

Forcing people to use const structures is good, but I think it would be
better without the macro, just by marking the argument in 
devm_phy_create() as const.

	Arnd
