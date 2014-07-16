From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Jul 2014 22:23:40 +0100
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <53C525A2.8080609@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
 <20140714181338.GR6800@sirena.org.uk> <53C525A2.8080609@kpanic.de>
Message-ID: <20140716212340.GZ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 02:59:14PM +0200, Stefan Assmann wrote:

> Looking at this more closely it seems to me that it's a regulator thing
> after all. In the end it all boils down to a single register write.
> twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x41, 0x8e);
> This is a write to the CLK32KG_CFG_STATE [1] register to power on the
> device.

The register description happening to mention power doesn't mean it's
not functionally an enable for a clock.

> I tried moving that to omap4xxx_dt_clk_init() but that won't work
> because the twl core structures aren't initialized yet.

> Any suggestions?

Why not just add this to (or create a new) clock driver for the chip?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/8e470177/attachment.sig>
