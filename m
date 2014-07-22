From: balbi@ti.com (Felipe Balbi)
Date: Tue, 22 Jul 2014 11:47:52 -0500
Subject: [PATCH] pinctrl: dra: dt-bindings: Fix pull enable/disable
In-Reply-To: <1406043594-14181-1-git-send-email-nm@ti.com>
References: <1406043594-14181-1-git-send-email-nm@ti.com>
Message-ID: <20140722164752.GJ20588@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 10:39:54AM -0500, Nishanth Menon wrote:
> The DRA74/72 control module pins have a weak pull up and pull down.
> This is configured by bit offset 17. if BIT(17) is 1, a pull up is
> selected, else a pull down is selected.
> 
> However, this pull resisstor is applied based on BIT(16) -
> PULLUDENABLE - if BIT(18) is *0*, then pull as defined in BIT(17) is
> applied, else no weak pulls are applied. We defined this in reverse.
> 
> Reference: Table 18-5 (Description of the pad configuration register
> bits) in Technical Reference Manual Revision (DRA74x revision Q:
> SPRUHI2Q Revised June 2014 and DRA72x revision F: SPRUHP2F - Revised
> June 2014)
> 
> Fixes: 6e58b8f1daaf1a ("ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Tested on an upcoming board.

Tested-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140722/fe4fb421/attachment.sig>
