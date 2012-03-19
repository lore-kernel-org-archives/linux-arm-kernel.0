From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 19 Mar 2012 15:42:06 +0800
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <4F6403CD.8020509@codeaurora.org>
References: <1330763341-3437-4-git-send-email-mturquette@linaro.org>
 <20120303133158.GA26882@pengutronix.de>
 <CAJOA=zNFNEHxBDhRDdvm7DYR83R0LJjsp_AT3BoG+nL+iN5_tw@mail.gmail.com>
 <20120304115201.GB26882@pengutronix.de>
 <CAJOA=zP8d8wm==7=svOzh03Ft-1_LV71q0mA6Pncrh5vQSWGEA@mail.gmail.com>
 <20120305073836.GU3852@pengutronix.de>
 <CAJOA=zMs75ZQ24g5PXpSLV3AJzWEo12g86G8+4+ryQR_cTYpzA@mail.gmail.com>
 <20120306190039.GJ3852@pengutronix.de>
 <CAJOA=zOG_6eSWPEfFL6VKWeTpGKD9y11xeHoOwdS3b59tAZ45A@mail.gmail.com>
 <4F6403CD.8020509@codeaurora.org>
Message-ID: <20120319074202.GD31410@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 08:23:57PM -0700, Saravana Kannan wrote:
> On 03/07/2012 01:20 PM, Turquette, Mike wrote:
...
> >Admittedly I think that the OMAP code could migrate some of these bits
> >to a lazy-registration model, specifically the hwmod object instances,
> >but that requires an awful lot of refactoring for a fairly large stack
> >of platform code.  This might be something to achieve in the future
> >but for now we *need* initialisation to be fully static.
> 
> When we work on moving clocks to device tree, wouldn't you face the
> same problem? You will have to dynamically create most of the clocks
> in that case too.
> 
>From what I heard from Mike[1], Omap will not have most of the clocks
encoded in device tree. 

Although my original preference was to have all the clocks represented
in device tree and dynamically registered to clk framework, I've heard
people including Grant incline to only have oscillator and leaf modules
clocks in device tree.  I somehow agree with that now, because having
all the clocks in there will bloat device tree dramatically, considering
there will be 3 clks, clk_gate, clk_divider and clk_mux backing one
clock in general.

Assuming we would agree to have most SoC internal clocks registered
from clock driver rather than device tree, I would like to hear about
how we should have these clock registered from clock driver, static
initialization or using register function?

-- 
Regards,
Shawn

[1] http://article.gmane.org/gmane.linux.linaro.devel/10554
