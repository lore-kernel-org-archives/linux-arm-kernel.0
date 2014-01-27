From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Jan 2014 14:14:39 +0800
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6sl
In-Reply-To: <c3acb9ee4a574bbaa1cdc5fa77050408@BY2PR03MB315.namprd03.prod.outlook.com>
References: <CACUGKYOgJDMO-xF9GC4Xh7+t6FDk6DwJ0iYX17Hh6LvqSjVa4Q@mail.gmail.com>
 <30BEA0EF-C7F3-48FB-9B07-2C244788DD38@freescale.com>
 <953bc7807ffe45119eece19c803b047f@BY2PR03MB315.namprd03.prod.outlook.com>
 <CACUGKYOuuPzPHyUSm_zyq1iq1FeaCoQ03Ko4yO8mmM+PDGm5gw@mail.gmail.com>
 <c3acb9ee4a574bbaa1cdc5fa77050408@BY2PR03MB315.namprd03.prod.outlook.com>
Message-ID: <20140127061434.GA3135@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 02:05:09AM +0000, Anson.Huang at freescale.com wrote:
> Hi, Tobias
> 	Yes, the root cause is the reschedule introduced by the usleep, for our internal release, we use busy loop for PLL wait lock, just removing the usleep is not good enough, as the PLL hardware may need about 60~90us to lock, during this period, there will be no clock output in PLL. So, we need to figure out a way to fix this issue, either using busy loop instead of usleep or access the ccm register to adjust ARM divider instead of calling clk APIs. 
> 

Yes, since imx6sl_set_wait_clk() is provided by imx6sl clock driver,
it's reasonable to just access register than going through clk API.

Shawn
