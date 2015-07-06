From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Jul 2015 12:30:14 +0200
Subject: [PATCH v3 3/4] mfd: axp20x: Add a cell for the usb power_supply
 part of the axp20x PMICs
In-Reply-To: <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150706103014.GH3269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 12:59:16PM +0200, Hans de Goede wrote:
> Add a cell for the usb power_supply part of the axp20x PMICs.
> 
> Note that this cell is only for the usb power_supply part and not the
> ac-power / battery-charger / rtc-backup-bat-charger bits.
> 
> Depending on the board each of those must be enabled / disabled separately
> in devicetree as most boards do not use all 4. So in dt each one needs its
> own child-node of the axp20x node. Another reason for using separate child
> nodes for each is so that other devicetree nodes can have a power-supply
> property with a phandle referencing a node representing a single
> power-supply.
> 
> The decision to use a separate devicetree node for each is reflected on
> the kernel side by each getting its own mfd-cell / platform_device and
> platform-driver.
> 
> Note this commit also makes some whitespace changes to the intialization
> of existing cells in axp20x_cells, these are pure whitespace changes,
> functionally nothing changes.
> 
> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/70906e2c/attachment.sig>
