From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Apr 2016 07:28:32 -0700
Subject: [PATCH net v3 0/5] drivers: net: cpsw: phy-handle fixes
In-Reply-To: <1461805808-4102-1-git-send-email-drivshin.allworx@gmail.com>
References: <1461805808-4102-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <20160428142832.GD5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* David Rivshin (Allworx) <drivshin.allworx@gmail.com> [160427 18:13]:
> From: David Rivshin <drivshin@allworx.com>
> 
> This series fixes a number of related issues around using phy-handle
> properties in cpsw emac nodes.
> 
> Patch 1 fixes a bug if more than one slave is used, and either
> slave uses the phy-handle property in the devicetree.
> 
> Patch 2 fixes a NULL pointer dereference which can occur if a
> phy-handle property is used and of_phy_connect() return NULL,
> such as with a bad devicetree.
> 
> Patch 3 fixes an issue where the phy-mode property would be ignored
> if a phy-handle property was used. This also fixes a bogus error
> message that would be emitted.
> 
> Patch 4 fixes makes the binding documentation more explicit that
> exactly one PHY property should be used, and also marks phy_id as
> deprecated.
> 
> Patch 5 cleans up the fixed-link case to work like the now-fixed
> phy-handle case.
> 
> I have tested on the following hardware configurations:
>  - (EVMSK) dual emac, phy_id property in both slaves
>  - (EVMSK) dual emac, phy-handle property in both slaves
>  - (EVMSK) a bad phy-handle property pointing to &mmc1
>  - (EVMSK) phy_id property with incorrect PHY address
>  - (BeagleBoneBlack) single emac, phy_id property
>  - (custom) single emac, fixed-link subnode
> 
> Andrew Goodbody reported testing v2 on a board that doesn't use
> dual_emac mode, but with 2 PHYs using phy-handle properties [1].
> 
> Nicolas Chauvet reported testing v2 on an HP t410 (dm8148).
> 
> Markus Brunner reported testing v1 on the following [2]:
>  - emac0 with phy_id and emac1 with fixed phy
>  - emac0 with phy-handle and emac1 with fixed phy
>  - emac0 with fixed phy and emac1 with fixed phy

Quickly boot tested these against next on dra62x-j5eco EVM:

Tested-by: Tony Lindgren <tony@atomide.com>
