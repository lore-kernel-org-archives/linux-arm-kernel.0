From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 10:58:12 +0100
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <53C78B20.6010602@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
 <20140714181338.GR6800@sirena.org.uk> <53C525A2.8080609@kpanic.de>
 <20140716212340.GZ17528@sirena.org.uk> <53C78B20.6010602@kpanic.de>
Message-ID: <20140717095812.GQ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 10:36:48AM +0200, Stefan Assmann wrote:
> On 16.07.2014 23:23, Mark Brown wrote:

> >Why not just add this to (or create a new) clock driver for the chip?

> Problem is that twl_i2c_write_u8() calls twl_get_regmap() to get the
> regmap. This requires struct twl_priv to be populated which does not
> happen until twl_probe has run. That hasn't happened at the point when
> omap4xxx_dt_clk_init() gets called.
> Is there a way to defer a clock driver until twl_probe() has run?

Why would probe deferral not work the same way as it does for
everything, and what does the core SoC clocking have to do with this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/26c50cd8/attachment.sig>
