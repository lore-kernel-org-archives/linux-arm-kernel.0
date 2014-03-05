From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Mar 2014 17:34:30 +0100
Subject: [PATCH v3 2/5] i2c: mv64xxx: Add support for the Allwinner A31
 I2C driver
In-Reply-To: <1393950521-4173-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140305163430.GC9228@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 05:28:38PM +0100, Maxime Ripard wrote:
> The Allwinner A31 I2C controller is almost identical to the one used in the
> other Allwinner SoCs, except for the fact that it needs to clear the interrupt
> by setting the INT_FLAGS bit in the control register, instead of clearing it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!

Still...

> +	if (of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
> +		drv_data->irq_clear_inverted = true;

... next time an errata is needed, I think it makes sense to refactor all
these checks into one struct which can be used as match->data directly.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/ac325c78/attachment-0001.sig>
