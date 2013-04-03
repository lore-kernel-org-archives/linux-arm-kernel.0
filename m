From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Apr 2013 18:48:07 +0300
Subject: [PATCH v5 2/6] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <201304031455.47864.arnd@arndb.de>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
 <1364993634-6378-3-git-send-email-kishon@ti.com>
 <20130403134827.GF14680@arwen.pp.htv.fi>
 <201304031455.47864.arnd@arndb.de>
Message-ID: <20130403154807.GE19093@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 03, 2013 at 02:55:47PM +0000, Arnd Bergmann wrote:
> On Wednesday 03 April 2013, Felipe Balbi wrote:
> > const ? Maybe provide a:
> > 
> > #define DEFINE_PHY_OPS(name)    \
> > const struct phy_ops #name_phy_ops = {
> > 
> > macro ? This will force people to add the const keyword :-)
> 
> Forcing people to use const structures is good, but I think it would be
> better without the macro, just by marking the argument in 
> devm_phy_create() as const.

that won't force the definition of the struct to be const, however. But
I get your point.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/661c611c/attachment-0001.sig>
