From: stefan@agner.ch (Stefan Agner)
Date: Thu, 11 Aug 2016 16:57:48 -0700
Subject: [PATCH] clk: imx7d: do not set the parent of
 IMX7D_ENET_AXI_ROOT_SRC
In-Reply-To: <CAOMZO5Dns1eNwzo2qz+Zh506D+JzdgJGYOzL8URTMfrxLq1XxQ@mail.gmail.com>
References: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5BjdhCDNU-Vr7OT81ag0LqgFQ3+oP1D_o0FUOZVafneqQ@mail.gmail.com>
 <20160811222842.GM2996@codeaurora.org>
 <CAOMZO5Dns1eNwzo2qz+Zh506D+JzdgJGYOzL8URTMfrxLq1XxQ@mail.gmail.com>
Message-ID: <88d5c57d3047176ebf2eec0f21e86613@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016-08-11 16:53, Fabio Estevam wrote:
> Hi Stephen,
> 
> On Thu, Aug 11, 2016 at 7:28 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
>> Is there a "Fixes:" tag that can be applied here? Does this
> 
> This parent assignment exists since the mx7d clk driver was introduced
> in commit 8f6d8094b21 ("ARM: imx: add imx7d clk tree support").
> 
>> depend on some sort of DTS changes to add assigned clocks and
>> parents?
> 
> All the mx7 dts users assign the ENET clocks in their dts files.

I don't think so, at least not that root clock.

Otherwise grep -e IMX7D_PLL_ENET_MAIN_250M_CLK arch/arm/boot/dts/imx7*
should return something...

I guess in practice it is not a problem because the boot loader
configures the clock selection already. Still, I think we should also
fix our device trees and select the root clock there...

--
Stefan
