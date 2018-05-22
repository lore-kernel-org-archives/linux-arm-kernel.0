From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:56:53 -0500
Subject: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
In-Reply-To: <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
 <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180522175652.GA4795@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 09:01:05AM +0800, Anson Huang wrote:
> Correct enet clock gates as below:
> 
> CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
> CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
> CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK
> 
> Just rename unused IMX7D_ENETx_REF_ROOT_CLK for
> IMX7D_ENETx_IPG_ROOT_CLK instead of adding new clocks.
> 
> Based on Andy Duan's patch from the NXP kernel tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c             | 10 ++++++----

>  include/dt-bindings/clock/imx7d-clock.h |  4 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 8 insertions(+), 6 deletions(-)
