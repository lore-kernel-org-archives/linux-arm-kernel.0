From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 17 Oct 2018 07:28:44 +0000
Subject: [PATCH V4 05/11] clk: imx: scu: add scu clock gate
In-Reply-To: <153972471150.5275.14761857440358508106@swboyd.mtv.corp.google.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-6-git-send-email-aisheng.dong@nxp.com>
 <20181015073207.66npcgegibl2rybb@pengutronix.de>
 <AM0PR04MB4211129386C9088C6AFEDAF580FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181015095342.kjokajxyugugbtcw@pengutronix.de>
 <AM0PR04MB42111FD6D3542E12250E556880FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <153972471150.5275.14761857440358508106@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB4211CA6F8AF1A312A516DB0180FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Wednesday, October 17, 2018 5:19 AM

[...]

> > " Drivers don't need to manually protect resources shared between the
> > operations of one group, regardless of whether those resources are
> > shared by multiple clocks or not. However, access to resources that
> > are shared between operations of the two groups needs to be protected by
> the drivers."
> >
> > Do you think it's okay to drop it?
> >
> 
> No it's not OK. We prefer that clk drivers don't assume the global locks in the
> clk framework are going to protect them from concurrent access to the same
> resource between different clks. Drivers can assume that a clk op won't be
> called in parallel for the same clk, but they shouldn't assume that everything is
> protected otherwise. If they did, we would have to go find all the drivers that
> make this assumption and then fix them when we eventually split the lock into
> smaller pieces.
> 
> Long story short, if you have something shared (i.e. a register) and you plan to
> write to it and read from it for multiple clks, add a lock around it.

Okay, got it. Appreciated for the detailed explanation.

Regards
Dong Aisheng
