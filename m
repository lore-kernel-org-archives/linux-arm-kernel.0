From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 19:01:50 +0100
Subject: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
In-Reply-To: <CAGo_u6ov=yaCwt8apbvW57ErAvhgUBHHw9gwADBC1fJUrfucUQ@mail.gmail.com>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
 <20130610103131.GR31367@sirena.org.uk>
 <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
 <20130610164905.GJ1403@sirena.org.uk>
 <CAGo_u6ov=yaCwt8apbvW57ErAvhgUBHHw9gwADBC1fJUrfucUQ@mail.gmail.com>
Message-ID: <20130610180150.GQ1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:51:42PM -0500, Nishanth Menon wrote:

> a) Tegra seems to use Lookup Table for sending predefinied voltage
> values to PMIC. OMAP has no concept of lookup table.

They seem to be doing basically the same thing here, you've got a linear
map of selector to voltage too AFAICT.

> b) Tegra and OMAP h/w blocks seem to use I2C - that is good.
> c) How about the i2c slave and register addresses, slew rates, start,
> end voltages, max voltages that SoC can support etc, I am yet to
> understand those.
> d) OMAP has 3 modules - AVS (SmartReflex), Voltage Processor(VP),
> Voltage Controller(VC) - I am not yet sure about the Tegra hardware
> blocks involved.

This all seems like it's at the implementation detail level - the bit
that seems like we should be able to share it is the big picture bit for
how we describe how the AP side stuff and PMIC are hooked up without
having to have a bunch of completely non-framework stuff for things
like describing the PMIC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/df7b5ca6/attachment.sig>
