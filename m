From: alexg@meprolight.com (Alex Gershgorin)
Date: Wed, 28 Mar 2012 19:38:56 +0200
Subject: [PATCH] mfd: mc13xxx: add I2C support fix building for v3.4
In-Reply-To: <20120328163512.GB3232@opensource.wolfsonmicro.com>
References: <1332943273-22447-1-git-send-email-alexg@meprolight.com>
 <20120328144017.GV3232@opensource.wolfsonmicro.com>
 <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD25@MEP-EXCH.meprolight.com>,
 <20120328163512.GB3232@opensource.wolfsonmicro.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD26@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> You ask me about another solution?

> > I'm saying either I'm missing something or this needs to be fixed in the
> > patches that introduce the regmap usage.

You understood correctly, it took me time to understand :-)
No problem I can split this patch:

> > +     select REGMAP_I2C if I2C
> > +     select REGMAP_SPI if SPI_MASTER

It will go to  v4 mfd: mc13xxx-core: use regmap for register access, 

Only the second part will be in this patch

-	struct device_node *np = mc13xxx->dev.of_node;
+	struct device_node *np = mc13xxx->dev->of_node;

 
