From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Aug 2016 18:45:19 -0700
Subject: [PATCH] clk: imx7d: do not set the parent of
 IMX7D_ENET_AXI_ROOT_SRC
In-Reply-To: <CAOMZO5AYVbobwxyNippO_AviZhNjCS0hhC2NmLHiPEt8MoP-5Q@mail.gmail.com>
References: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5BjdhCDNU-Vr7OT81ag0LqgFQ3+oP1D_o0FUOZVafneqQ@mail.gmail.com>
 <20160811222842.GM2996@codeaurora.org>
 <CAOMZO5Dns1eNwzo2qz+Zh506D+JzdgJGYOzL8URTMfrxLq1XxQ@mail.gmail.com>
 <88d5c57d3047176ebf2eec0f21e86613@agner.ch>
 <CAOMZO5AYVbobwxyNippO_AviZhNjCS0hhC2NmLHiPEt8MoP-5Q@mail.gmail.com>
Message-ID: <20160812014519.GO2996@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11, Fabio Estevam wrote:
> Hi Stefan,
> 
> On Thu, Aug 11, 2016 at 8:57 PM, Stefan Agner <stefan@agner.ch> wrote:
> 
> > I don't think so, at least not that root clock.
> >
> > Otherwise grep -e IMX7D_PLL_ENET_MAIN_250M_CLK arch/arm/boot/dts/imx7*
> > should return something...
> 
> Yes, you are right. The enet root clock parent assignment is missing in dts.
> 
> Other enet clocks are assigned.
> 
> > I guess in practice it is not a problem because the boot loader
> > configures the clock selection already. Still, I think we should also
> > fix our device trees and select the root clock there...
> 
> Yes, I didn't see any error on mx7d-sdb when I tested this patch, but
> to be on the safe side I will update all the mx7 fec users to assign
> enet root clk in the dts.
> 

Ok it sounds like this isn't urgent for fixes. I'll go ahead and
queue it up for v4.9

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
