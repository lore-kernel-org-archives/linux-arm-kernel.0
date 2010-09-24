From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 24 Sep 2010 08:43:10 +0200
Subject: [PATCH 0/4] Adding support for esdhc on mx35/51
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
Message-ID: <20100924064310.GA30543@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> * About the share between i.MX and PPC eSDHC.
> Why configure a few parts be shared between the i.MX eSDHC and PPC
> eSDHC? Can they be separated into two independent systems?

The rule of thumb is to avoid code-duplication. Assume the PPC driver gets
fixed an off-by-one error in the freq-calculation, you surely want to have that
fix on imx, too.

> It would bring the conveniences to maintain stuff in the future if we
> separate them.

If you can name these conveniences and they are convincing, we can keep them
seperate. At the moment, I don't see them (what doesn't mean they don't exist)

> And there is already one set of eSDHC driver for all the i.MX SOCs.

I am confused: which set do you mean?

> As we know that i.MX and PPC are the disparate SOC families.

Well, if the eSDHC-core itself is the same or very similar, that doesn't really
matter IMO. Especially as the of-platform-bus might disappear somewhen in the
future, the PPC and imx-drivers could become more similar.

> * About the driver name of i.MX eSDHC driver, I think that use the imx
> to identify it is better than esdhc.

I picked up Anton's suggestion 'sdhci-esdhc-imx.c' so far. Although I am still
not sure if 'sdhci-esdhc-pltfm.c' would be more precise.

> As I know that the eSDHC name wouldn't be used anymore in next
> generation SOCs of i.MX family.
> So the name of imx would be much clear and exact.

Not really, because all _existing_ implementations are called eSDHC, no? :) If
some future incarnations have a different name, but behave the same or very
similar, this is usually no problem. Check for example the I2C eeprom driver
which is named 'at24' but support basically all EEPROMs and not only Atmel
ones. Same goes for a couple of RTC-drivers, etc...

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100924/b4783607/attachment.sig>
