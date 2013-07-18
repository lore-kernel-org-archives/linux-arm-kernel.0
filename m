From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 11:08:00 +0100
Subject: [PATCH v1 05/24] clk: wrap I/O access for improved portability
In-Reply-To: <20130718080657.GI10380@pengutronix.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
 <20130718070402.GO7080@book.gsilab.sittig.org>
 <20130718080657.GI10380@pengutronix.de>
Message-ID: <20130718100800.GF22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:06:57AM +0200, Sascha Hauer wrote:

> I think regmap has the potential to solve a number of issues like the
> hardcoded readl/writel in the common clock blocks, issues with i2c
> clocks and your endianess issue. The biggest question probably is how
> to get there without putting too much of a burden on you. It's probably
> not an option to convert all users to regmap, so it seems additional
> functions like clk_register_gate_regmap are better to handle.

That's basically what regulator does.  There's versions of the ops that
all the drivers can use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/43ffb513/attachment.sig>
