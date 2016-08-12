From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 11 Aug 2016 22:35:56 -0300
Subject: [PATCH] clk: imx7d: do not set the parent of
 IMX7D_ENET_AXI_ROOT_SRC
In-Reply-To: <88d5c57d3047176ebf2eec0f21e86613@agner.ch>
References: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5BjdhCDNU-Vr7OT81ag0LqgFQ3+oP1D_o0FUOZVafneqQ@mail.gmail.com>
 <20160811222842.GM2996@codeaurora.org>
 <CAOMZO5Dns1eNwzo2qz+Zh506D+JzdgJGYOzL8URTMfrxLq1XxQ@mail.gmail.com>
 <88d5c57d3047176ebf2eec0f21e86613@agner.ch>
Message-ID: <CAOMZO5AYVbobwxyNippO_AviZhNjCS0hhC2NmLHiPEt8MoP-5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Thu, Aug 11, 2016 at 8:57 PM, Stefan Agner <stefan@agner.ch> wrote:

> I don't think so, at least not that root clock.
>
> Otherwise grep -e IMX7D_PLL_ENET_MAIN_250M_CLK arch/arm/boot/dts/imx7*
> should return something...

Yes, you are right. The enet root clock parent assignment is missing in dts.

Other enet clocks are assigned.

> I guess in practice it is not a problem because the boot loader
> configures the clock selection already. Still, I think we should also
> fix our device trees and select the root clock there...

Yes, I didn't see any error on mx7d-sdb when I tested this patch, but
to be on the safe side I will update all the mx7 fec users to assign
enet root clk in the dts.

Thanks
