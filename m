From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Oct 2017 14:33:15 +0100
Subject: [PATCH v10 0/8] net: stmmac: dwmac-sun8i: Handle integrated PHY
In-Reply-To: <20171031081915.18960-1-clabbe.montjoie@gmail.com>
References: <20171031081915.18960-1-clabbe.montjoie@gmail.com>
Message-ID: <20171031133315.qe74frvm6gt3qsta@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 09:19:07AM +0100, Corentin Labbe wrote:
> Hello
> 
> The current way to find if the PHY is internal is to compare DT phy-mode
> and emac_variant/internal_phy.
> But it will negate a possible future SoC where an external PHY use the
> same phy mode than the integrated one.
> 
> This patchs series adds a new way to handle this problem via a mdio-mux.
> 
> The first try was to create a new MDIO mux "mdio-mux-syscon".
> mdio-mux-syscon working the same way than mdio-mux-mmioreg with the exception
> that the register is used via syscon/regmap.
> But this solution does not work for two reason:
> - changing the MDIO selection need the reset of MAC which cannot be done by the
>         mdio-mux-syscon driver
> - There were driver loading order problem:
>         - mdio-mux-syscon needing that stmmac register the parent MDIO
>         - stmmac needing that child MDIO was registered just after registering parent MDIO
> 
> So we cannot use any external MDIO-mux.
> 
> The final solution was to represent the mdio-mux in MAC node and let
> the MAC handle all things.
> 
> Since DT bits was reverted in 4.13, this patch series include the
> revert of the revert.
> 
> I have let patch splited for easy review. (for seeing what's new)
> But the final serie could have some patch squashed if someone want.
> Like squashing patch and 1 and 2 (documentation)

Applied the patches, and I'll send a PR for it tomorrow after one
linux-next run.

Hopefully it will be merged in time for 4.15.

Thanks for your persistence,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171031/65777a98/attachment.sig>
