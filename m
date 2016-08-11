From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 11 Aug 2016 20:53:06 -0300
Subject: [PATCH] clk: imx7d: do not set the parent of
 IMX7D_ENET_AXI_ROOT_SRC
In-Reply-To: <20160811222842.GM2996@codeaurora.org>
References: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5BjdhCDNU-Vr7OT81ag0LqgFQ3+oP1D_o0FUOZVafneqQ@mail.gmail.com>
 <20160811222842.GM2996@codeaurora.org>
Message-ID: <CAOMZO5Dns1eNwzo2qz+Zh506D+JzdgJGYOzL8URTMfrxLq1XxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Aug 11, 2016 at 7:28 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Is there a "Fixes:" tag that can be applied here? Does this

This parent assignment exists since the mx7d clk driver was introduced
in commit 8f6d8094b21 ("ARM: imx: add imx7d clk tree support").

> depend on some sort of DTS changes to add assigned clocks and
> parents?

All the mx7 dts users assign the ENET clocks in their dts files.

As imx7s-warp is the only affected board and it will be only available
in 4.9, I think it is OK to apply this one into clk-next if you are
happt with it.

Thanks,

Fabio Estevam
