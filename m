From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 22 Aug 2013 15:14:17 +0200
Subject: [RFC PATCH] phylib: mdio: handle register/unregister/register
 sequence
In-Reply-To: <1377174836-10569-1-git-send-email-b.brezillon@overkiz.com>
References: <1377174836-10569-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52160EA9.4060801@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/2013 14:33, Boris BREZILLON wrote:
> Hello,
>
> This patch is a proposal to support the register/unregister/register
> sequence on a given mdio bus.

I forgot to ask, if this limitation was made on purpose ?
In other terms: no one should ever try to register, unregister and 
register again
a given mii_bus structure.

>
> I use the register/unregister/register sequence to add a fallback when the
> of_mdiobus_register (this function calls mdiobus_register with phy_mask
> set to ~0) does not register any phy device (because the device tree does
> not define any phy).
> In this case I call mdiobus_unregister and then call mdiobus_register with
> a phy_mask set to 0 to trigger a full mdio bus scan.
>
> I'm not sure this is the right way to do it (this is why I added RFC in the
> subject).
>
> Could someone help me figuring out what I should use to implement my fallback ?
>
> 1) use the register/unregister/register sequence
> 2) reimplement the "for (i = 0; i < PHY_MAX_ADDR; i++)" mdiobus_scan loop
>
> Thanks.
>
> Best Regards,
> Boris
>
> Boris BREZILLON (1):
>    phylib: mdio: handle register/unregister/register sequence
>
>   drivers/net/phy/mdio_bus.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
